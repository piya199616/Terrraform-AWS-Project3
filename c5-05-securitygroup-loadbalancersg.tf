# Create Security Group-Load balancer


resource "aws_security_group" "loadbalancer_sg" {
  name        = "loadbalancer-sg"
  description = "http open for entire Internet and Egress ports for everyone"
  vpc_id = module.vpc.vpc_id

  
  ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #This is a list item
    
  }

  ingress {
    description      = "Allow port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]#This is a list item
    
  }

  ingress {
    
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow Port 81 from internet"
      cidr_blocks = ["0.0.0.0/0"]
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