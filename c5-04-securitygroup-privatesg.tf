# AWS EC2 Security Group Terraform Module
# Security Group for Private Security Group
/*
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name = "private_sg"
  description =  "Security group with HTTP & SSH ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  #Ingress Rules and CIDR block

  ingress_rules            = ["ssh-22-tcp", "http-80-tcp"]
  ingress_cidr_blocks      = [module.vpc.vpc_cidr_block]



  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}

*/
# Create Security Group-WEB Traffic

resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow WEB for private vm"
  vpc_id = module.vpc.vpc_id

  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.vpc_cidr_block] #This is a list item
    
  }
  ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.vpc_cidr_block] #This is a list item
    
  }

  ingress {
    description      = "Allow port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.vpc_cidr_block]#This is a list item
    
  }


  egress {
    description = "Allow all ip and ports outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = local.common_tags
}