variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment (dev, prod, etc.)"
  type        = string
}

variable "volume_ids" {
  description = "A list of EBS Volume IDs to create initial snapshots for"
  type        = list(string)
  default     = []
}