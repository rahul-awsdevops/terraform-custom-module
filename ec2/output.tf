output "instance_id" {
  value = aws_instance.this.id
}

output "eip" {
  value = var.create_eip ? aws_eip.this.public_ip : null
}

output "ebs_volume_id" {
  value = var.create_extra_ebs ? aws_ebs_volume.extra_volume.id : null
}
