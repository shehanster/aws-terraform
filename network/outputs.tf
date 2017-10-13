output "private_subnets_ids" {
  value = "${join(",", aws_subnet.private_subnets.*.id)}"
}

output "public_subnets_ids" {
  value = "${join(",", aws_subnet.public_subnets.*.id)}"
}

output "db_subnets_ids" {
  value = "${join(",", aws_subnet.db_subnets.*.id)}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_route_table_id" {
  value = "${aws_route_table.public_route_table.id}"
}

output "private_route_table_id" {
  value = "${aws_route_table.private_route_table.id}"
}

output "api_cloud_security_group_id" {
  value = "${aws_security_group.api_cloud_security_group.id}"
}

output "dmz_security_group_id" {
  value = "${aws_security_group.dmz_security_group.id}"
}
