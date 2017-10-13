variable "access_key" {}

variable "secret_key" {}

variable "aws_key_path" {}

variable "aws_key_name" {}

variable "region" {
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "A String of VPC CIDR notation for public use"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A list of subnets in CIDR notation for public use"
  type        = "list"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
