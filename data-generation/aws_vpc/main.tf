# Resource to create VPC resource and set cidr block.
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "test-vpc"
  }
}

# Resource to crete a output vpc_id to use this id for other resources like security group,network acl
output "vpc_id" {
  value = aws_vpc.main.id
}
