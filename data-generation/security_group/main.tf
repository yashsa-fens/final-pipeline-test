# Resource to create a security group for allow all tls traffic.
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

# Resource to create a security group for allow all traffic.
resource "aws_security_group" "example" {
  name        = "allow_all_trafic"
  description = "Allow all traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_all_trafic"
  }
}

# Resource to create a ingress rules for allow_tls security group
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Resource to create a ingress rules for allow_tls security group
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Resource to create a defualt security group and bydefault allow all traffic
resource "aws_default_security_group" "name" {
  vpc_id = var.vpc_id
  tags = {
    Name = "default"
  }
}
