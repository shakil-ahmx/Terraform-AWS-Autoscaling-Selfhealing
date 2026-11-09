variable "name" {
  type = string
}

variable "ami_id" {
  description = "Optional custom AMI. Empty = latest Amazon Linux 2023."
  type        = string
  default     = ""
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = ""
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "security_group_id" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "min_size" {
  type    = number
  default = 2
}

variable "desired_capacity" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 3
}

variable "tags" {
  type    = map(string)
  default = {}
}
