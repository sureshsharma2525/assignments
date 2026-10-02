output "ec2_instance_ids" {
  description = "instance name to instance ID"
  value = {
    for name, instance in aws_instance.ec2_instance :
    name => instance.id
  }
}

output "private_ips" {
  description = "instance name to private IP"
  value = {
    for name, instance in aws_instance.ec2_instance :
    name => instance.private_ip
  }
}