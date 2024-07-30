# Login-profile and create iam user can be called as below as per need

# Module to add iam_role to iam user
module "aws_iam_role" {
  source = "./iam_role"
}

# Module to add access_key to iam user
module "aws_iam_access_key" {
  source = "./iam_access_key"
  users  = var.users
}

# Module to attach iam_user_policy
module "aws_iam_user_attach_policy" {
  source   = "./attach_policy"
  for_each = var.users
  users    = each.key
}

# Module to create a tls certificate
module "aws_iam_user_tls_certificate" {
  source = "./tls_certificate"
}
