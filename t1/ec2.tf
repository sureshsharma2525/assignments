data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "ec2_instance" {
  for_each = var.Instances
  ami           = data.aws_ami.amazon_linux.id
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  root_block_device {
    volume_type = each.value.root_volume.type
    volume_size = each.value.root_volume.size
  }
  tags = {
    Name        = each.key
    Environment = "assignment"
    Owner       = "terraform"
  }
  lifecycle {
    prevent_destroy = each.key == "ec2-01"
  }
}