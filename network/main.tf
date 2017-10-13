resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.name}"
  }
}

#Configure public routing
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}-public_route_table"
  }
}

resource "aws_route" "internet_gateway_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}



resource "aws_subnet" "public_subnets" {
  count                   = "${length(var.public_subnets)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${element(var.public_subnets, count.index)}"
  availability_zone       = "${element(var.azs_public, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${format("%s_public_subnet-0%d", var.name, count.index + 1)}"
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

#Configure private routing
resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}-private_route_table"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = "${length(var.private_subnets)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${element(var.azs_private, count.index)}"

  tags {
    Name = "${format("%s_private-subnet_0%d", var.name, count.index + 1)}"
  }
}

resource "aws_route_table_association" "private_route_association" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

resource "aws_subnet" "db_subnets" {
  count             = "${length(var.db_subnets)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.db_subnets, count.index)}"
  availability_zone = "${element(var.azs_db, count.index)}"

  tags {
    Name = "${format("%s_db-subnet_0%d", var.name, count.index + 1)}"
  }
}

#Nat gateway for private instances
resource "aws_eip" "nat_elastic_ip" {
  vpc   = true
  count = "${var.nat_gateway_count}"
}

resource "aws_nat_gateway" "private_nat_gateway" {
  count         = "${var.nat_gateway_count}"
  allocation_id = "${element(aws_eip.nat_elastic_ip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnets.*.id, count.index)}"
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = "${element(aws_route_table.private_route_table.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.private_nat_gateway.*.id, count.index)}"
  depends_on             = ["aws_route_table.private_route_table"]
}

resource "aws_eip" "bastion_eip" {
  #instance = "${aws_instance.bastion_instance.id}"
  depends_on = ["aws_instance.bastion_instance"]
  vpc = true
}

#Bastion instance Create

resource "aws_instance" "bastion_instance" {
  ami = "${var.centos_ami}"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.bastion_security_group.id}"]
  subnet_id = "${aws_subnet.public_subnets.0.id}"
  source_dest_check = "False"

  tags {
    Name = "${var.name}_Bastion_Instance"
  }

}

resource "aws_route" "vpn_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "10.0.0.0/16"
  instance_id            = "${aws_instance.ipsec_instance.id}"
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "dbsubnet"
  subnet_ids = ["${aws_subnet.db_subnets.0.id}", "${aws_subnet.db_subnets.1.id}"]
  description = "db replication group"

  tags {
    Name = "Subnet group for db"
  }
}


}
