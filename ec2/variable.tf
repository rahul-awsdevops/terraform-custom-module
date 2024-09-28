# New variable to control EC2 instance creation
variable "create_ec2" {
  description = "Create EC2 instance and associated resources"
  type        = bool
  default     = true
}

variable "ami" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be deployed"
  type        = string
}

variable "vpc_security_group_ids"{
  description = "List of security group IDs to attach to the instance"
  type        = list(string)
}

variable "availability_zone" {
  description = "Availability zone to launch the instance in"
  type        = string
}

variable "org" {
  description = "Organization name for standard naming convention"
  type        = string
}

variable "env" {
  description = "Environment (e.g., dev, prod) for standard naming convention"
  type        = string
}

variable "application" {
  description = "Application name for standard naming convention"
  type        = string
}

variable "use_case" {
  description = "The use case or purpose for the EC2 instance"
  type        = string
}

variable "instance_profile_arn" {
  description = "IAM Instance profile ARN (if any)"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data script for instance setup"
  type        = string
  default     = ""
}

variable "create_eip" {
  description = "Create and attach an Elastic IP to the instance"
  type        = bool
  default     = false
}


variable "ebs_device_name" {
  description = "Device name for the EBS volume"
  type        = string
  default     = "/dev/sdf"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = null
}

variable "additional_tags" {
  description = "Additional tags for the instance"
  type        = map(string)
  default     = {}
}

variable "create_extra_ebs" {
  description = "Whether to create an extra EBS volume"
  type        = bool
  default     = false
}

variable "ebs_volume_size" {
  description = "Size of the additional EBS volume if created"
  type        = number
  default     = 0
}


