############################
# 1) AMI - Amazon Linux 2  #
############################
data "aws_ami" "al2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#########################################
# 2) SSH key generation & key pair (TLS)#
#########################################
# הערה: בתרגיל זה נוח. בפרוד לא שומרים מפתח ב-state.
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename        = "${path.module}/builder_key.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"
}

resource "aws_key_pair" "builder" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

###########################
# 3) Security Group (SG)  #
###########################
resource "aws_security_group" "builder_sg" {
  name        = "builder-sg"
  description = "Allow SSH (22) and HTTP (5001) from student IP"
  vpc_id      = var.vpc_id
  tags        = var.tags

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  # Python app port (5001)
  ingress {
    description = "Python app on 5001"
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  # Allow all outbound
  egress {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

############################
# 4) EC2 Instance "builder"#
############################
resource "aws_instance" "builder" {
  ami                         = data.aws_ami.al2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id # ← הסאבנט הציבורית שבחרת
  vpc_security_group_ids      = [aws_security_group.builder_sg.id]
  key_name                    = aws_key_pair.builder.key_name
  associate_public_ip_address = true

  tags = merge(var.tags, { Name = "builder" })

  # דיסק מערכת (בתוך ה-resource)
  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }
}