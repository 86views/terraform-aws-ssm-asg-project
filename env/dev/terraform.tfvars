# Core Configuration
aws_region   = "us-east-1"
project_name = "ssm-asg-project"
environment  = "dev"

# Networking
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]
enable_nat_gateway   = false  # Set to false for dev to save costs

# Compute
instance_type     = "t3.micro"  # Free tier eligible
root_volume_size  = 20  

# Integrations (UPDATE THESE!)
github_repo       = "86views/terraform-aws-ssm-asg-project"  
alert_email       = "oluleye.oluseun@gmail.com"  
slack_webhook_url = "https://app.slack.com/client/T09KH6M8WFN/C09KBHHE87Q"