# Terraform – AWS EC2 “builder”

## 🎯 Objective
Provision an **EC2 instance** named **builder** in **us-east-1**, inside your own **VPC** and **Public Subnet**, including:
- Generating an SSH key pair (private key stored locally with `0600` permissions, public key uploaded to AWS as a Key Pair).
- Creating a Security Group allowing **SSH (22)** and **HTTP (5001)** only from **your IPv4 address**.
- Providing Terraform outputs (Public IP, key file path, SG ID, and Key Pair name).

---

## 🧱 Repo Layout (suggested)
```
project-rolling/
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── providers.tf
    ├── versions.tf
    ├── .terraform.lock.hcl
    └── .gitignore
```

---

## ⚙️ Prerequisites
- Terraform ≥ 1.6
- AWS CLI configured with valid credentials (`aws configure`)
- AWS account with an existing **Public Subnet** (`MapPublicIpOnLaunch=true`)
- Region: **us-east-1**

---

## 🌍 Variables
Defined in `variables.tf`:

| Variable        | Description                                  | Example                   |
|-----------------|----------------------------------------------|---------------------------|
| `vpc_id`        | The VPC where the instance will be deployed  | `vpc-0788f6c0feac2a6a3`   |
| `subnet_id`     | Public subnet within that VPC                | `subnet-01349f3dbd5b1dcc8`|
| `instance_type` | EC2 instance type (Free Tier eligible)        | `t3.micro`                |
| `allowed_cidr`  | Your IPv4 address in CIDR format             | `1.2.3.4/32`              |
| `key_name`      | Name for the generated AWS Key Pair          | `builder-key`             |
| `tags`          | Map of tags applied to created resources     | `{ Project="devops-builder", Owner="student" }` |

---

## 🚀 Usage

### 1️⃣ Set Environment Variables
Before running Terraform, set the following (adjust with your values):

```bash
cd terraform

export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1

export TF_VAR_vpc_id="vpc-0788f6c0feac2a6a3"
export TF_VAR_subnet_id="subnet-01349f3dbd5b1dcc8"
export TF_VAR_instance_type="t3.micro"                   # Free Tier
export TF_VAR_allowed_cidr="$(curl -4 -s ifconfig.me)/32" # Your current IPv4
```

> Ensure the subnet is **public** (MapPublicIpOnLaunch=true), otherwise the instance won’t get a public IP.

---

### 2️⃣ Initialize and Validate
```bash
terraform init
terraform validate
```

### 3️⃣ Plan and Lock Configuration
```bash
terraform plan -out=tfplan
```
Check that:
- `instance_type = "t3.micro"`
- `vpc_id`, `subnet_id` are correct
- SG allows ports **22** and **5001** to your `allowed_cidr`

### 4️⃣ Apply the Plan
```bash
terraform apply tfplan
```

Terraform will:
- Create a **Key Pair** in AWS using your generated public key.
- Create a **Security Group** with restricted inbound rules.
- Launch an **EC2 instance** named `builder` (Amazon Linux 2, Public IP assigned).

---

## 🔎 Outputs
After deployment, run:
```bash
terraform output
```

Example:
```
instance_public_ip     = "34.207.95.99"
ssh_key_name           = "builder-key"
security_group_id      = "sg-0abc1234def567890"
ssh_private_key_path   = "builder_key.pem"
```

---

## 🔐 SSH Connection
```bash
chmod 600 builder_key.pem
ssh -i builder_key.pem ec2-user@<instance_public_ip>
```

---

## 🌐 Verify Port 5001
On the instance:
```bash
python3 -m http.server 5001
```
Then open in your browser:
```
http://<instance_public_ip>:5001
```
If you see a “Directory listing” page — success ✅

---

## 🧹 Cleanup
Destroy all resources to avoid charges:
```bash
terraform destroy -auto-approve
```

---

## 👤 Author
**Yuval Vos**  
DevOps AWS Terraform Project – 2025
