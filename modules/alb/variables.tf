variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the Target Group will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "The security group ID to attach to the ALB"
  type        = string
}