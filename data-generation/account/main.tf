# Module to violate account password policy rules
module "account_password_policy" {
  source = "./account_password_policy"
}

# Module to violate iam role without support role rule
module "iam_role_without_support_roles" {
  source = "./iam_role_without_support_roles"
}
