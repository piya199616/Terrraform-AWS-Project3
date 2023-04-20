
# Public Bastion Host Security Group Outputs
output "public_bastion_sg_id" {
  description = "The ID of the security group"
  value       = [aws_security_group.bastion_sg.id]
}

# Private EC2 Instances Security Group Outputs
#private_sg_id
output "private_sg_id" {
  description = "The ID of the security group"
  value       = [aws_security_group.private_sg.id]
}
/*
#public_bastion_sg_vpc_id
output "public_bastion_sg_vpc_id" {
  description = "The VPC ID"
  value       = [aws_security_group.bastion_sg.this_security_group_vpc_id]
}

#public_bastion_sg_group_name
output "public_bastion_sg_group_name" {
  description = "The name of the security group"
  value       = [aws_security_group.bastion_sg.this_security_group_name]
}

# Private EC2 Instances Security Group Outputs
#private_sg_id
output "private_sg_id" {
  description = "The ID of the security group"
  value       = module.private_sg.this_security_group_id
}

#private_sg_vpc_id
output "private_sg_vpc_id" {
  description = "The VPC ID"
  value       = module.private_sg.this_security_group_vpc_id
}

#private_sg_group_name
output "private_sg_group_name" {
  description = "The name of the security group"
  value       = module.private_sg.this_security_group_name
}
*/