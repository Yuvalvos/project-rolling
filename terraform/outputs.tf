#####################################
# Terraform Outputs - DevOps Project
#####################################

# כתובת ה־IP הציבורית של ה־EC2
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.builder.public_ip
}

# מיקום קובץ ה־SSH פרטי במחשב שלך
output "ssh_private_key_path" {
  description = "Path to the generated private SSH key"
  value       = local_file.private_key.filename
  sensitive   = true
}

# מזהה Security Group
output "security_group_id" {
  description = "Security Group ID created for the instance"
  value       = aws_security_group.builder_sg.id
}

# מזהה ה־Subnet שבו הושק ה־Instance
output "subnet_id_used" {
  description = "Subnet ID used to launch the instance"
  value       = var.subnet_id
}

# שם ה־Key Pair שנוצר
output "ssh_key_name" {
  description = "AWS key pair name created by Terraform"
  value       = aws_key_pair.builder.key_name
}