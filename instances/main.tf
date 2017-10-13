resource "aws_instance" "api_instance" {

    count = "${var.api_instance_count}"

    ami = "${var.ami_id}"

    vpc_security_group_ids = ["${var.security_group_ids}"]

    subnet_id = "${element(split(",", var.private_subnets_ids), count.index%2)}"

    instance_type = "${var.api_instance_type}"

    user_data =  "${file("${path.module}/user_data/api-instance.yml")}"

    key_name = "${var.aws_key_name}"


    tags {

      Environment = "${var.environment}"
      Name = "${var.name}_Api-instance-${format("%02d", count.index+1)}"
      Service = 	"api"


    }

}
