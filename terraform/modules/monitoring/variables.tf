variable "name" {
  type = string
}

variable "alert_email" {
  description = "Email address subscribed to the SNS topic"
  type        = string
}

variable "asg_name" {
  type = string
}

variable "scale_up_policy_arn" {
  type = string
}

variable "scale_down_policy_arn" {
  type = string
}

variable "cpu_high_threshold" {
  type    = number
  default = 40
}

variable "cpu_low_threshold" {
  type    = number
  default = 20
}

variable "enable_scale_down" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
