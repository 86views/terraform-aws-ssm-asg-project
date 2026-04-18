provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "ssm-asg-project"
      ManagedBy   = "Terraform"
      CostCenter  = "infrastructure"
    }
  }
}