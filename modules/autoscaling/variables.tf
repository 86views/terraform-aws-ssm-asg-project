variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The deployment environment (dev, staging, prod)"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs where the ASG will launch instances"
  type        = list(string)
}

variable "launch_template_id" {
  description = "The ID of the launch template to use for the ASG"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the ALB target group to associate with the ASG"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "The desired number of instances in the ASG"
  type        = number
  default     = 1
}