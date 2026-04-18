variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "asg_name" {
  description = "The name of the Auto Scaling Group to monitor"
  type        = string
}

variable "alert_email" {
  description = "Email address to receive SNS alerts"
  type        = string
}

variable "slack_webhook_url" {
  description = "The Slack Incoming Webhook URL for notifications"
  type        = string
  sensitive   = true
}