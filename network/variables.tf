variable "name" {
  description = "The name of the vpc to be used in tagging"
}

variable "cidr" {
  description = "IP CIDR block of the vpc network"
}

variable "public_subnets" {
  description = "A list of subnets in CIDR notation for public use"
  default     = []
}

variable "private_subnets" {
  description = "A list of subnets in CIDR notation for private use"
  default     = []
}

variable "db_subnets" {
  description = "A list of subnets in CIDR notation for db use"
  default     = []
}

variable "azs_public" {
  description = "A list of Availablity Zone for each public subnet listed. Element count must match public_subnets"
  default     = []
}

variable "azs_private" {
  description = "A list of Availablity Zone for each private subnet listed. Element count must match private_subnets"
  default     = []
}

variable "azs_db" {
  description = "A list of Availablity Zone for each private subnet listed. Element count must match private_subnets"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "True if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "True if you want to use private DNS within the VPC"
  default     = true
}

variable "centos_ami" {
  default = "ami-#######"
}

variable "bastion_az" {
  default = "ap-southeast-1"
}

variable "aws_key_name" {
  default = ""
}

variable "aws_key_path" {
  default = ""
}

variable "nat_gateway_count" {
  default = "1"
}

variable "ami_id" {
  default = "ami-########"
