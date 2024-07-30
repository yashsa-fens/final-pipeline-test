# Resource to create network acl resource.
resource "aws_network_acl" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name = "example-acl"
  }
}

# Resource to create rules for network acl.
resource "aws_network_acl_rule" "ssh_ingress" {
  network_acl_id = aws_network_acl.main.id
  rule_number    = 200
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  to_port        = 22 # set port of server administrator
  from_port      = 22
}

# Resource to create rules for network acl.
resource "aws_network_acl_rule" "rdp_ingress" {
  network_acl_id = aws_network_acl.main.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  to_port        = 3389
  from_port      = 3389
}
