variable "ami_id" {
  default = "ami-123456"
}

variable "api_instance_type" {
  default = "t2.micro"
}

variable "private_subnets_ids" {}

variable "public_subnets_ids" {}

variable "api_instance_count" {
  description = "Number of instance(s) to be launched"
  default     = 2
}

variable "nginx_instance_count" {
  default = "1"
}

variable "nginx_instance_type" {
  default = "t2.micro"
}

variable "name" {}

variable "aws_key_path" {}

variable "aws_key_name" {}

variable "security_group_ids" {}

variable "ebs_root_volume_type" {
  default = "gp2"
}

variable "ebs_root_volume_size" {
  default = "25"
}

variable "ebs_root_delete_on_termination" {
  default = "true"
}
