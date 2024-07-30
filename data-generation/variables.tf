# Variable for secret access-key of aws
variable "access_key" {
  description = "access-Key of aws"
  type        = string
}

# Variable for secret key of aws
variable "secret_key" {
  description = "secret key of aws"
  type        = string
}

# Variable for map of all user
variable "users" {
  type        = map(map(string))
  description = "map of all users"
}
