variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where endpoints are created"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to associate with the endpoints"
  type        = list(string)
}

variable "ssm_endpoint_sg_id" {
  description = "The security group ID for the SSM VPC endpoints"
  type        = string
}