output "vpc_id" {
  description = "ID of the VPC in use"
  value       = data.aws_vpc.this.id
}

output "subnet_ids" {
  description = "Subnet IDs in use"
  value       = local.subnet_ids
}
