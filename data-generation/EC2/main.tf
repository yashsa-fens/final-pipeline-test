# Replace the placeholder values with your actual configuration settings.

# AWS EC2 Instance configuration
resource "aws_instance" "example" {
  ami           = "ami-04629cfb3bd2d73f3" # Replace with your actual AMI ID
  instance_type = "t2.micro"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
    encrypted             = false # This disables encryption
  }

  tags = {
    Name = "ExampleInstance"
  }
}

# AWS Volume Attachment configuration
resource "aws_volume_attachment" "example" {
  device_name  = "/dev/sdh"
  volume_id    = aws_ebs_volume.example.id
  instance_id  = aws_instance.example.id
  force_detach = true
}

# AWS EBS Volume configuration
resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1a"
  size              = 8     # Size in GB
  encrypted         = false # Intentionally violating the encryption rule
  snapshot_id       = "snap-0c8e7f08bad5b13f2"

  tags = {
    Name = "UnencryptedVolume"
  }
}
