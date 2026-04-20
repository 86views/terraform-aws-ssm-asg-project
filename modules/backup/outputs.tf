output "dlm_policy_arn" {
  description = "ARN of the DLM lifecycle policy"
  value       = aws_dlm_lifecycle_policy.ebs_backup.arn
}

output "dlm_role_arn" {
  description = "ARN of the DLM IAM role"
  value       = aws_iam_role.dlm_role.arn
}



