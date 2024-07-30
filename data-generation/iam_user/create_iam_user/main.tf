# Resource to create iam_user
resource "aws_iam_user" "user" {
  name = var.iam_user_name
}
