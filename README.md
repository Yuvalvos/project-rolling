# 🚀 Project Rolling – AWS Resource Dashboard & CI/CD Pipeline

A comprehensive DevOps project featuring a **Flask web application** that monitors AWS resources, integrated with a full **CI/CD Pipeline** using Jenkins, Docker, and Security scanning tools.

---

## 🛠️ Tech Stack & DevOps Tools

- **Application:** Python 3, Flask, Boto3 (AWS SDK).
- **CI/CD Platform:** Jenkins (Pipeline as Code).
- **Containerization:** Docker.
- **Security Scanning:** Trivy (FS & Vulnerability scanning).
- **Static Code Analysis:** Flake8 (Linting).
- **Infrastructure:** Terraform (Planned IaC).
- **Registry:** Docker Hub.

---

## 🏗️ Project Structure

The repository is organized according to industry best practices, separating application logic from infrastructure and configuration:

```text
project-rolling/
│
├── python/                 # Application source code
│   ├── app.py              # Main Flask application (Listening on Port 5001)
│   └── requirements.txt    # Python dependencies
│
├── terraform/              # Infrastructure as Code (IaC) configurations
│
├── docs/                   # Documentation and project screenshots
│   └── pipeline-success.png # Jenkins pipeline success screenshot
│
├── Dockerfile              # Docker image configuration (Root directory)
├── Jenkinsfile             # Declarative Pipeline configuration (Root directory)
├── .gitignore              # Git ignore file
└── README.md               # Project documentation
🔄 CI/CD Pipeline Workflow
The Jenkins pipeline is defined in a declarative Jenkinsfile and automatically triggers on every push to the main branch:

Checkout SCM: Pulls the latest code from the GitHub repository.

Quality & Security (Parallel Execution):

Linting: Runs Flake8 on the python/ directory to ensure PEP8 compliance and code quality.

Security Scan: Uses Trivy to scan the filesystem for vulnerabilities and exposed secrets.

Build Docker Image: Builds a production-ready Docker image using the root Dockerfile, ensuring the application and dependencies are correctly packaged.

Push to Docker Hub: Authenticates, tags, and pushes the final image to the registry: yuvalv1288/project-rolling-app:latest.

Pipeline Success View:

📦 Containerization & Deployment
To run the application locally or on a server using the Docker image:

Bash
# 1. Pull the image from Docker Hub
docker pull yuvalv1288/project-rolling-app:latest

# 2. Run the container
# Note: Port 5001 is used to avoid conflicts
docker run -d -p 5001:5001 \
  -e AWS_ACCESS_KEY_ID=your_access_key \
  -e AWS_SECRET_ACCESS_KEY=your_secret_key \
  -e AWS_REGION=eu-north-1 \
  yuvalv1288/project-rolling-app:latest
🔐 AWS Credentials Setup
The application requires AWS credentials with programmatic access and the following permissions:

ec2:DescribeInstances

ec2:DescribeVpcs

elasticloadbalancing:DescribeLoadBalancers

ec2:DescribeImages

Security Note: In the Jenkins pipeline, these credentials are securely managed using the Jenkins Credentials Store and are never hardcoded in the source.

🖥️ Application Features
The web interface provides a real-time dashboard for AWS resources:

EC2 Dashboard: List of instances, their types, public IPs, and current states.

Network Overview: Displays VPCs and subnets within the configured region.

Load Balancers: Lists ALBs/NLBs along with their DNS names.

AMI Management: Displays Amazon Machine Images owned by the account.

Developed by Yuval Vos DevOps Project Rolling