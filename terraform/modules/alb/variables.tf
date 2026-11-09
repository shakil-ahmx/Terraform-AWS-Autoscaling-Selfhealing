variable "name" {
  description = "Name prefix (ALB/TG names are limited to 32 chars)"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  description = "Subnets for the ALB (minimum 2 AZs)"
  type        = list(string)
}

variable "security_group_id" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
