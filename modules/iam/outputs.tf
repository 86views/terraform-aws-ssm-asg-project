# Outputs (kept in main.tf)
output "ec2_instance_profile_name" {
  description = "The name of the IAM instance profile for EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}

