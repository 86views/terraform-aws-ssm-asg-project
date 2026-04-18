output "sns_topic_arn" {
  description = "The ARN of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.arn
}

output "lambda_function_arn" {
  description = "The ARN of the Slack notifier Lambda function"
  value       = aws_lambda_function.slack_notifier.arn
}

output "high_cpu_alarm_arn" {
  description = "The ARN of the High CPU CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.arn
}