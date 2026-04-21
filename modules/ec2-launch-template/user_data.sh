resource "aws_launch_template" "example" {
  name_prefix   = "${var.project_name}-${var.environment}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = base64encode(<<-EOF
#!/bin/bash
set -e

# Install CloudWatch Agent
sudo yum update -y
sudo yum install -y amazon-cloudwatch-agent

# Install and start httpd
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

# Create index.html
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${var.project_name} Dashboard</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f4f7f6; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }
        .container { 
            background: white; 
            padding: 2rem; 
            border-radius: 12px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
            border-top: 8px solid #232f3e; 
            width: 400px;
        }
        h1 { color: #232f3e; margin-bottom: 0.5rem; font-size: 1.5rem; }
        .badge { 
            background: #ff9900; 
            color: white; 
            padding: 4px 12px; 
            border-radius: 20px; 
            font-size: 0.8rem; 
            font-weight: bold;
        }
        .data-row { 
            display: flex; 
            justify-content: space-between; 
            padding: 10px 0; 
            border-bottom: 1px solid #eee; 
        }
        .label { font-weight: 600; color: #666; }
        .value { color: #333; font-family: 'Courier New', Courier, monospace; }
        .footer { margin-top: 1.5rem; font-size: 0.7rem; color: #aaa; text-align: center; }
    </style>
</head>
<body>
    <div class="container">
        <h1>${var.project_name}</h1>
        <span class="badge">Environment: ${var.environment}</span>
        <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
        
        <div class="data-row">
            <span class="label">Instance ID:</span>
            <span class="value">$(curl -s http://169.254.169.254/latest/meta-data/instance-id)</span>
        </div>
        
        <div class="data-row">
            <span class="label">Availability Zone:</span>
            <span class="value">$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</span>
        </div>

        <div class="data-row">
            <span class="label">Private IP:</span>
            <span class="value">$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</span>
        </div>

        <p class="footer">Deployed via Oluleye Oluseun Oluwatobi oluwadamilare oooooooo and  thhhe AWS terraform & GitHub Actions</p>
        <p> @86views </p>
    </div>
</body>
</html>
EOF

# Configure CloudWatch Agent
cat <<EOF | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "cwagent"
  },
  "metrics": {
    "metrics_collected": {
      "cpu": {
        "measurement": ["cpu_usage_idle", "cpu_usage_user", "cpu_usage_system"],
        "metrics_collection_interval": 60
      },
      "disk": {
        "measurement": ["used_percent"],
        "metrics_collection_interval": 60,
        "resources": ["/"]
      },
      "mem": {
        "measurement": ["mem_used_percent"],
        "metrics_collection_interval": 60
      }
    }
  }
}
EOF

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
EOF
  )

  metadata_options {
    http_tokens = "required"  # Forces IMDSv2
    http_endpoint = "enabled"  # Required when http_tokens is set to "required"
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [aws_security_group.ec2.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-${var.environment}-ec2-instance"
    }
  }
}