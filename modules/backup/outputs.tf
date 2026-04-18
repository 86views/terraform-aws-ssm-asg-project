output "dlm_lifecycle_policy_id" {
  description = "The ID of the DLM lifecycle policy"
  value       = aws_dlm_lifecycle_policy.ebs_backup.id
}

output "dlm_role_arn" {
  description = "The ARN of the IAM role used by DLM"
  value       = aws_iam_role.dlm_role.arn
}

output "manual_snapshot_ids" {
  description = "The IDs of any manually triggered snapshots"
  value       = values(aws_ebs_snapshot.volume_snapshots)[*].id
}