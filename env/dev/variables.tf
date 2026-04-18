# Global / Naming
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

# Networking
variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}
variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "Whether to create a NAT gateway for private subnet internet access. Set to false in dev to save costs."
}

# Compute
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "root_volume_size" {
  type    = number
  default = 20
}

# IAM / GitHub
variable "github_repo" {
  type        = string
  description = "Format: username/repository"
}

# Monitoring
variable "alert_email" {
  type = string
}

variable "slack_webhook_url" {
  type      = string
  sensitive = true
}