# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
/*
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name = "public_bastion_sg"
  description =  "Security Group with SSh port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  #Ingress Rules and CIDR block

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["ssh-22-tcp"]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}
*/
# Create Security Group-SSH Traffic

resource "aws_security_group" "bastion_sg" {
  name        = "public-sg"
  description = "Allow SSH for bastion"
  vpc_id = module.vpc.vpc_id
  
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #This is a list item
    
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "VPC-ssh"
  }
}

