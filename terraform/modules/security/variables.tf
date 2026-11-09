variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC in which to create the security groups"
  type        = string
}

variable "alb_ingress_cidrs" {
  description = "CIDR blocks allowed to reach the ALB on port 80"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}
