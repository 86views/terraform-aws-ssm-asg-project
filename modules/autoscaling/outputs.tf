output "as_group_id" {
  description = "The ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.id
}

output "as_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.name
}

output "as_group_arn" {
  description = "The ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.arn
}