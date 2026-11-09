variable "vpc_id" {
  description = "VPC ID. Empty string means: use the region's default VPC."
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Subnet IDs (at least 2 AZs). Empty list means: use all subnets in the VPC."
  type        = list(string)
  default     = []
}
