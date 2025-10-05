# 🚀 Project Rolling – AWS Resource Dashboard

A simple **Flask web app** running on an **EC2 instance (Amazon Linux 2023)** that uses **Boto3** to fetch and display live information about your AWS resources:

- EC2 Instances  
- VPCs  
- Load Balancers (ALB/NLB)  
- Available (owned) AMIs  

---

## 📦 Features

- Displays **running EC2 instances** including their public IPs, types, and states.  
- Lists all **VPCs** in your AWS region.  
- Shows **Application / Network Load Balancers** and their DNS names.  
- Displays **AMIs** owned by your AWS account.  

---

## 🧠 Technologies Used

- **Python 3**
- **Flask** (for the web framework)
- **Boto3** (AWS SDK for Python)
- **Amazon EC2 (Amazon Linux 2023)**

---

## ⚙️ Setup Instructions

### 1. Clone this repository

```bash
git clone https://github.com/Yuvalvos/project-rolling.git
cd project-rolling
```

### 2. (Optional) Create a virtual environment
```bash
python3 -m venv venv
source venv/bin/activate
```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```
or manually:
```bash
pip install flask boto3
```

---

## 🔐 AWS Credentials Setup

The app uses environment variables for AWS credentials.

Set them like this:

### On Mac/Linux:
```bash
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_REGION=eu-north-1
```

### On Windows (CMD):
```bash
set AWS_ACCESS_KEY_ID=your_access_key
set AWS_SECRET_ACCESS_KEY=your_secret_key
set AWS_REGION=eu-north-1
```

> ⚠️ **Never hardcode your AWS keys in the code!**

---

## 🏃 Running the Application

Run the Flask app:
```bash
python3 app.py
```

Then open your browser at:

👉 `http://<your-ec2-public-ip>:5001`

---

## 🖥️ Output Example

The web app will show tables listing:
- **Running EC2 Instances**
- **VPCs**
- **Load Balancers**
- **Available AMIs**

Example view:

| ID | State | Type | Public IP |
|----|--------|------|-----------|
| i-015d8204df23b7888 | running | c7i-flex.large | 13.62.19.154 |

---

## 🧾 Project Structure

```
project-rolling/
│
├── app.py
├── requirements.txt
├── .gitignore
└── README.md
```

---

## ✅ Requirements

- Python 3.7+
- AWS account with the following permissions:
  - `ec2:DescribeInstances`
  - `ec2:DescribeVpcs`
  - `ec2:DescribeImages`
  - `elasticloadbalancing:DescribeLoadBalancers`

---

## 🖼️ Screenshots

**Running on EC2**
![EC2 Instance](aws/ec2_instance.png)

**Web App Output**
![App Output](aws/web_output.png)

---

## 📜 License

This project is open-source and free to use.  

---

## 🙋 Support

Created by **Yuval Vos**  
Feel free to open issues or suggestions in this repository.
