output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.ec2.id
}

output "ssm_endpoint_security_group_id" {
  description = "The ID of the SSM Endpoint security group"
  value       = aws_security_group.ssm_endpoint.id
}