# CloudWatch Alarm - High CPU
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-${var.environment}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 70
  alarm_description  = "EC2 CPU utilization is above 70%"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

# CloudWatch Alarm - Low CPU
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${var.project_name}-${var.environment}-low-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 30
  alarm_description  = "EC2 CPU utilization is below 30%"
  alarm_actions      = [aws_sns_topic.alerts.arn]
}

# CloudWatch Alarm - Status Check Failed
resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "${var.project_name}-${var.environment}-status-check-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name        = "StatusCheckFailed"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 1
  alarm_description  = "EC2 status check failed"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

# SNS Topic for alerts
resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-${var.environment}-alerts"
}

# Email subscription
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# Slack webhook integration (using Lambda)
resource "aws_lambda_function" "slack_notifier" {
  filename         = data.archive_file.slack_lambda.output_path
  function_name    = "${var.project_name}-${var.environment}-slack-notifier"
  role            = aws_iam_role.slack_lambda.arn
  handler         = "index.handler"
  runtime         = "nodejs18.x"
  source_code_hash = data.archive_file.slack_lambda.output_base64sha256

  environment {
    variables = {
      SLACK_WEBHOOK_URL = var.slack_webhook_url
    }
  }
}

data "archive_file" "slack_lambda" {
  type        = "zip"
  output_path = "/tmp/slack_lambda.zip"
  source {
    content  = <<EOF
exports.handler = async (event) => {
  const https = require('https');
  const message = event.Records[0].Sns.Message;
  
  const data = JSON.stringify({
    text: `🚨 AWS Alert: ${message}`
  });
  
  const url = new URL(process.env.SLACK_WEBHOOK_URL);
  const options = {
    hostname: url.hostname,
    path: url.pathname,
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    }
  };
  
  return new Promise((resolve) => {
    const req = https.request(options, (res) => {
      resolve({ statusCode: res.statusCode });
    });
    req.write(data);
    req.end();
  });
};
EOF
    filename = "index.js"
  }
}

resource "aws_sns_topic_subscription" "slack" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.slack_notifier.arn
}

resource "aws_lambda_permission" "sns_invoke" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack_notifier.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.alerts.arn
}

resource "aws_iam_role" "slack_lambda" {
  name = "${var.project_name}-${var.environment}-slack-lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.slack_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}