variable "project_name" {}
variable "environment" {}
variable "tags" { type = map(string) }

# Add this line:
variable "github_repo" {
  description = "The GitHub repository for OIDC permissions"
  type        = string
}