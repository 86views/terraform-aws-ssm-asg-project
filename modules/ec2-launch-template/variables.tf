variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type (e.g., t3.micro)"
  type        = string
  default     = "t3.micro"
}

variable "instance_profile_name" {
  description = "The name of the IAM instance profile for SSM access"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to attach to the network interface"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 20
}