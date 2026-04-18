output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "ALB zone ID"
  value       = module.alb.alb_zone_id
}

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = module.autoscaling.asg_name
}