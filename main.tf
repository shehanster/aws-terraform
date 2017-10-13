# Configure the AWS Resource Manager Provider
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Create a vpc network
module "network" {
  source          = "./network"
  name            = "Prod"
  cidr            = "${var.vpc_cidr}"
  public_subnets  = ["172.22.253.0/24", "172.22.254.0/24"]
  private_subnets = ["172.22.10.0/24", "172.22.11.0/24"]
  db_subnets      = ["172.22.100.0/24", "172.22.101.0/24"]
  azs_private     = ["ap-southeast-1a", "ap-southeast-1b"]
  azs_public      = ["ap-southeast-1a", "ap-southeast-1b"]
  azs_db          = ["ap-southeast-1a", "ap-southeast-1b"]
  aws_key_path    = "${var.aws_key_path}"
  aws_key_name    = "${var.aws_key_name}"
}

module "instances" {
  source              = "./instances"
  name                = "Prod"
  aws_key_path        = "${var.aws_key_path}"
  aws_key_name        = "${var.aws_key_name}"
  security_group_ids  = "${module.network.api_cloud_security_group_id}"
  private_subnets_ids = "${module.network.private_subnets_ids}"
  public_subnets_ids  = "${module.network.public_subnets_ids}"
}
