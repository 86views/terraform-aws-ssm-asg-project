output "ssm_endpoint_id" {
  description = "The ID of the SSM interface endpoint"
  value       = aws_vpc_endpoint.ssm.id
}

output "ssm_messages_endpoint_id" {
  description = "The ID of the SSM Messages interface endpoint"
  value       = aws_vpc_endpoint.ssm_messages.id
}

output "ec2_messages_endpoint_id" {
  description = "The ID of the EC2 Messages interface endpoint"
  value       = aws_vpc_endpoint.ec2_messages.id
}

output "logs_endpoint_id" {
  description = "The ID of the CloudWatch Logs interface endpoint"
  value       = aws_vpc_endpoint.logs.id
}