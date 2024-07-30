# Define an IAM user policy named "example-policy" and attach it to specified user(s)
resource "aws_iam_user_policy" "example_policy" {
  name = "example-policy"
  user = var.users

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "*",
        "Resource": "*"
      }
    ]
  }
  EOF
}

# Attach the AmazonS3FullAccess policy to the specified user(s)
resource "aws_iam_user_policy_attachment" "example_attachment" {
  user       = var.users
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Attach the AdministratorAccess policy to the specified user(s)
resource "aws_iam_user_policy_attachment" "admin_attachment" {
  user       = var.users
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
