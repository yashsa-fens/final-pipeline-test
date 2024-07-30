# variable for access-key of aws
variable "access_key" {
  description = "access-Key of aws"
  type        = string
}

# variable for secret key of aws
variable "secret_key" {
  description = "secret key of aws"
  type        = string
}

# variable for map of all user
variable "users" {
  type        = map(map(string))
  description = "map of all users"
}
