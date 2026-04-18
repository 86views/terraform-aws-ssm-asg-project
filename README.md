# terraform-aws-ssm-asg-project

Production-ready Terraform infrastructure for deploying AWS Auto Scaling Group (ASG) instances managed via AWS Systems Manager (SSM), behind an Application Load Balancer (ALB), with monitoring, backup, IAM, and modular architecture.

---

## 🏗️ Architecture Overview

This project provisions:

* VPC with public & private subnets
* Security Groups
* IAM roles for EC2 & SSM
* EC2 Launch Template
* Auto Scaling Group (ASG)
* Application Load Balancer (ALB)
* AWS Systems Manager (SSM) access
* Monitoring (CloudWatch)
* Backup configuration
* GitHub Actions CI/CD workflow

---

## 📁 Project Structure

```
terraform-aws-ssm-asg-project/
│
├── .github/workflows/terraform.yml   # CI/CD pipeline
│
├── backend/                          # Remote state backend
│
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── iam/
│   ├── ec2-launch-template/
│   ├── autoscaling/
│   ├── alb/
│   ├── monitoring/
│   ├── backup/
│   └── ssm/
│
├── env/dev/                          # Environment configuration
│
├── versions.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

## ⚙️ Features

✅ Modular Terraform structure
✅ Environment-based deployments
✅ Auto Scaling Group with Launch Template
✅ ALB Load Balancing
✅ AWS Systems Manager (No SSH needed)
✅ IAM Least privilege roles
✅ CloudWatch monitoring
✅ Backup configuration
✅ GitHub Actions CI/CD
✅ Remote backend support

---

## 🚀 Getting Started

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/terraform-aws-ssm-asg-project.git
cd terraform-aws-ssm-asg-project
```

---

### 2. Configure AWS Credentials

```bash
aws configure
```

OR

```bash
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION=""
```

---

### 3. Initialize Terraform

```bash
terraform init
```

---

### 4. Select Environment

```bash
cd env/dev
```

---

### 5. Plan Deployment

```bash
terraform plan
```

---

### 6. Apply Infrastructure

```bash
terraform apply
```

---

## 🧪 Destroy Infrastructure

```bash
terraform destroy
```

---

## 🔐 Accessing EC2 via SSM (No SSH)

After deployment:

1. Go to AWS Console
2. Navigate to Systems Manager
3. Session Manager
4. Start Session
5. Select instance

No SSH keys required 🔒

---

## 🔄 CI/CD

GitHub Actions workflow:

```
.github/workflows/terraform.yml
```

Pipeline stages:

* Terraform Format
* Terraform Init
* Terraform Validate
* Terraform Plan
* Terraform Apply (optional)

---

## 🌎 Environments

Currently supported:

* dev

You can add:

```
env/
 ├── dev
 ├── staging
 └── prod
```

---

## 📦 Modules

| Module              | Description               |
| ------------------- | ------------------------- |
| vpc                 | Network infrastructure    |
| security-group      | Security rules            |
| iam                 | IAM roles & policies      |
| ec2-launch-template | EC2 configuration         |
| autoscaling         | Auto Scaling Group        |
| alb                 | Application Load Balancer |
| monitoring          | CloudWatch alarms         |
| backup              | Backup plan               |
| ssm                 | Systems Manager setup     |

---

## 🛡️ Best Practices Implemented

* Modular Terraform structure
* Remote backend ready
* Least privilege IAM
* No SSH (SSM only)
* Separate environment configs
* CI/CD validation
* Scalable ASG design

---

## 📄 Requirements

* Terraform >= 1.5
* AWS CLI
* AWS Account
* GitHub repository (for CI/CD)

---

## 👨‍💻 Author

DevOps Terraform ASG + SSM Project

---

## 📜 License

MIT License
