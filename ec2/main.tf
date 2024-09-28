# EC2 Instance Configuration
resource "aws_instance" "this" {
  count = var.create_ec2 ? 1 : 0  # Create only if create_ec2 is true

  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name             =   var.key_name
  iam_instance_profile   = var.instance_profile_arn != "" ? var.instance_profile_arn : null
  user_data              = var.user_data != "" ? var.user_data : null

  # Tagging based on organizational standards
  tags = merge({
    Name        = "${local.naming_convention}-ec2"
  }, var.additional_tags)
}

# Create Elastic IP and associate with EC2 if create_eip is true
resource "aws_eip" "this" {
  count = var.create_ec2 && var.create_eip ? 1 : 0  # Create only if both create_ec2 and create_eip are true
  instance = aws_instance.this[count.index].id
  tags = merge({
    Name = "${local.naming_convention}-eip"
  }, var.additional_tags)
}

# Create additional EBS volume if create_extra_ebs is true
resource "aws_ebs_volume" "extra_volume" {
  count             = var.create_extra_ebs ? 1 : 0
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size

  tags = {
    Name = "${local.naming_convention}-volume"
  }
}

# Attach the extra EBS volume to the EC2 instance if it exists
resource "aws_volume_attachment" "ebs_attachment" {
  count        = var.create_extra_ebs ? 1 : 0
  device_name  = "/dev/sdf"   # Can be adjusted as needed
  instance_id  = aws_instance.this.id
  volume_id    = aws_ebs_volume.extra_volume.id
}
