output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.main.id
}

output "launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = aws_launch_template.main.latest_version
}

output "ami_id_used" {
  description = "The ID of the Amazon Linux 2 AMI used for this template"
  value       = data.aws_ami.amazon_linux_2.id
}


output "volume_ids" {
  description = "EBS volume IDs from the launch template"
  value       = aws_launch_template.main.block_device_mappings[*].ebs[*].volume_size
}
