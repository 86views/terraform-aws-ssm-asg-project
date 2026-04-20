# Load Balancer URL - This is how you access your app
output "application_url" {
  description = "The DNS name of the Load Balancer"
  value       = "http://${module.alb.alb_dns_name}"
}

# Networking Details
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

# Auto Scaling Details
output "autoscaling_group_name" {
  value = module.autoscaling.as_group_name
}

# Monitoring / Alerts
output "sns_topic_arn" {
  value = module.monitoring.sns_topic_arn
}

output "github_actions_role_arn" {
  value = module.iam.github_actions_role_arn
}