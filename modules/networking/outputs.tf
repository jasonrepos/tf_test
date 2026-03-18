output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "subnet_ids" {
  description = "Map of subnet name to subnet ID"
  value       = { for k, v in aws_subnet.this : k => v.id }
}

output "security_group_ids" {
  description = "Map of security group name to ID"
  value       = { for k, v in aws_security_group.this : k => v.id }
}


