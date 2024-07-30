# This resource set minimum password length 10 for all iam user within an account. 
# Password reuse prevention set to 1 it violates 2 rule.
resource "aws_iam_account_password_policy" "example_policy" {
  minimum_password_length        = 10 # set the lenght 14 to violate rule
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = 1 # set to greater than 3 for violate rule.
}
