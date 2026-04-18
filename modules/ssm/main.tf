# SSM VPC Endpoint
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [var.ssm_endpoint_sg_id]

  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-${var.environment}-ssm-endpoint"
  }
}

# SSM Messages Endpoint
resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [var.ssm_endpoint_sg_id]

  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-${var.environment}-ssm-messages-endpoint"
  }
}

# EC2 Messages Endpoint
resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [var.ssm_endpoint_sg_id]

  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-${var.environment}-ec2-messages-endpoint"
  }
}

# CloudWatch Logs Endpoint (optional, for monitoring)
resource "aws_vpc_endpoint" "logs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [var.ssm_endpoint_sg_id]

  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-${var.environment}-logs-endpoint"
  }
}