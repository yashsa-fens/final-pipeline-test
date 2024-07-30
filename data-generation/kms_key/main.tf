# Resource to create kms key for encrypt a data.
resource "aws_kms_key" "example" {
  description = "example"
}

# Resource to create kms key alias 
resource "aws_kms_alias" "a" {
  name          = "alias/example-key"
  target_key_id = aws_kms_key.example.id
}

# Resource to create kms key policy.
# Give full privilage access to kms key.
resource "aws_kms_key_policy" "example" {
  key_id = aws_kms_key.example.id
  policy = jsonencode({
    Id = "example"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}
