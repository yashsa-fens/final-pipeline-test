# Define custom IAM policy for this role
data "aws_iam_policy_document" "role_without_supportrole_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets"
    ]
    resources = ["*"]
  }
}

# Resource to create iam role without creating aws support role.
resource "aws_iam_role" "role_without_supportrole" {
  name = "example-role-without-supportrole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "support.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Resource to create IAM policy for support role.
resource "aws_iam_policy" "role_without_supportrole_policy" {
  name        = "role-without-supportrole-policy"
  description = "Custom IAM policy for this role"
  policy      = data.aws_iam_policy_document.role_without_supportrole_policy.json
}

# Attach IAM policy to this role.
resource "aws_iam_role_policy_attachment" "role_without_supportrole_policy_attachment" {
  role       = aws_iam_role.role_without_supportrole.name
  policy_arn = aws_iam_policy.role_without_supportrole_policy.arn
}
