variable "vpc_id" {
  description = "Use ONLY this VPC (per the assignment)."
  type        = string
  default     = "vpc-044604d0bfb707142"
}

variable "instance_type" {
  description = "Instance type for the builder"
  type        = string
  default     = "t3.micro"
}

variable "allowed_cidr" {
  description = "Your public IP/CIDR allowed to SSH/HTTP (e.g., 1.2.3.4/32)"
  type        = string
}

variable "key_name" {
  description = "AWS key pair name to create"
  type        = string
  default     = "builder-key"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Project = "devops-builder"
    Owner   = "student"
  }
}
variable "subnet_id" {
  description = "(Optional) Explicit public subnet to launch the instance in"
  type        = string
  default     = ""
}