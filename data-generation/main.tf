terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Module to assign all IAM user policies
module "iam_user_all_rules_violation" {
  source     = "./iam_user"
  access_key = var.access_key
  secret_key = var.secret_key
  users      = var.users
}

# Module to violate cloudtrail and s3 bucket rules
module "cloudtrail_and_s3_bucket_rules_violation" {
  source = "./cloud_trail_and_s3_bucket"
}

# Module for give vpc id to security group and nework acl 
module "vpc_rules_violation" {
  source = "./aws_vpc"
}

# Module to violate security group rules
module "security_group_rules_violation" {
  source = "./security_group"
  vpc_id = module.vpc_rules_violation.vpc_id

}

# Module to violate network acl rules
module "network_acl_rules_violation" {
  source = "./network_acl"
  vpc_id = module.vpc_rules_violation.vpc_id
}

# Module to violate AWS account rules
module "account_rules_violation" {
  source = "./account"
}

# Module to violate kms key rules 
module "kms_key_rules_violation" {
  source = "./kms_key"
}

# Module to violate EC2 rules
module "EC2_rules_violation" {
  source = "./EC2"
}

# Module to violate RDS instance rules
module "RDS_rules_violation" {
  source = "./rds_instance"
}

# Module to violate Red Shift Cluster
# This module is yet to be tested as it is under paid resources 
# module "red_shift_cluster_rules_violation" {
#   source = "./red_shift_cluster"
# }

# Module to violate sns rules
module "sns_rules_violation" {
  source = "./sns"
}

# Module to violate sqs rules
module "sqs_rules_violation" {
  source    = "./sqs"
  topic_arn = module.sns_rules_violation.topic_arn
}
