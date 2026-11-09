variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1" # Mumbai
}

variable "project_name" {
  description = "Project name used as a resource-name prefix (keep it short)"
  type        = string
  default     = "demo"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "alert_email" {
  description = "Email address for CloudWatch/SNS alerts"
  type        = string

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.alert_email))
    error_message = "alert_email must be a valid email address."
  }
}

variable "vpc_id" {
  description = "VPC ID. Empty = default VPC"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Subnet IDs (2+ AZs). Empty = all subnets of the VPC"
  type        = list(string)
  default     = []
}

variable "alb_ingress_cidrs" {
  description = "CIDRs allowed to reach the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ami_id" {
  description = "Custom AMI ID. Empty = latest Amazon Linux 2023"
  type        = string
  default     = ""
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "key_name" {
  description = "Optional EC2 key pair name (Session Manager works without it)"
  type        = string
  default     = ""
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "asg_min_size" {
  type    = number
  default = 2
}

variable "asg_desired_capacity" {
  type    = number
  default = 2
}

variable "asg_max_size" {
  type    = number
  default = 6
}

variable "cpu_high_threshold" {
  description = "Average CPU % that triggers scale-up"
  type        = number
  default     = 40
}

variable "enable_deletion_protection" {
  description = "Protect the ALB from accidental deletion"
  type        = bool
  default     = true
}
