variable "name" {
  description = "Name prefix (keep short: IAM name_prefix is limited to 38 chars)"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
