output "alb_url" {
  description = "Open this URL in a browser"
  value       = "http://${module.alb.dns_name}"
}

output "asg_name" {
  value = module.compute.asg_name
}

output "ami_id" {
  value = module.compute.ami_id
}

output "sns_topic_arn" {
  value = module.monitoring.sns_topic_arn
}

output "region" {
  value = var.region
}
