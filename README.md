# EC2 Module for Terraform

This module creates an EC2 instance on AWS with customizable parameters. It simplifies the process of launching instances and managing their configurations.

## Inputs

| Variable                | Description                                                      | Type         | Default    |
|------------------------|------------------------------------------------------------------|--------------|------------|
| `create_ec2`          | Create EC2 instance and associated resources                     | `bool`       | `true`     |
| `ami`                  | AMI ID to use for the instance                                   | `string`     |            |
| `instance_type`        | EC2 instance type                                                | `string`     | `t3.micro` |
| `subnet_id`            | The subnet ID where the EC2 instance will be deployed           | `string`     |            |
| `vpc_security_group_ids`| List of security group IDs to attach to the instance            | `list(string)`|            |
| `availability_zone`    | Availability zone to launch the instance in                     | `string`     |            |
| `org`                  | Organization name for standard naming convention                 | `string`     |            |
| `env`                  | Environment (e.g., dev, prod) for standard naming convention    | `string`     |            |
| `application`          | Application name for standard naming convention                  | `string`     |            |
| `use_case`             | The use case or purpose for the EC2 instance                     | `string`     |            |
| `instance_profile_arn` | IAM Instance profile ARN (if any)                               | `string`     | `""`       |
| `user_data`            | User data script for instance setup                              | `string`     | `""`       |
| `create_eip`           | Create and attach an Elastic IP to the instance                 | `bool`       | `false`    |
| `ebs_device_name`      | Device name for the EBS volume                                   | `string`     | `"/dev/sdf"` |
| `key_name`             | Key pair name for SSH access                                     | `string`     | `null`     |
| `additional_tags`      | Additional tags for the instance                                 | `map(string)` | `{}`      |
| `create_extra_ebs`     | Whether to create an extra EBS volume                            | `bool`       | `false`    |
| `ebs_volume_size`      | Size of the additional EBS volume if created                    | `number`     | `0`        |

## Outputs

| Output                 | Description                                                      |
|-----------------------|-----------------------------------------------------------------|
| `instance_id`         | The ID of the created EC2 instance.                             |
| `public_ip`           | The public IP address of the created EC2 instance (if EIP is created). |
| `private_ip`          | The private IP address of the created EC2 instance.            |
| `security_group_ids`  | The security group IDs associated with the EC2 instance.       |

## Usage Example

```hcl
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
}

module "myec2" {
  source                  = "github.com/rahul-awsdevops/terraform-custom-module/ec2"
  org                     = "mycompany"
  env                     = "prod"
  application             = "backend"
  use_case                = "api-server"
  ami                     = data.aws_ami.amzlinux2.id
  instance_type          = "t3.medium"
  subnet_id              = "subnet-00db276fd1e46facc"
  vpc_security_group_ids  = ["sg-017fa4b91c728bb52"]
  availability_zone      = "us-east-1a"
  key_name               = "terraform-key"
  instance_profile_arn   = ""
  create_eip             = true
}

output "instance_id" {
  value = module.myec2.instance_id
}
