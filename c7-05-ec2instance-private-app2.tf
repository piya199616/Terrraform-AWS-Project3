# EC2 Instances that will be created in VPC Private Subnets

module "ec2_private_app2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"
  depends_on = [module.vpc]
  
  name = "${var.environment}-app2-${count.index}"
 
  count = 2
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = "terraform-key"
  #monitoring             = true
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  #subnet_id            = element(module.vpc.private_subnets, tonumber(each.key))
  subnet_id            = element(module.vpc.private_subnets, count.index)
  #subnet_id = module.vpc.private_subnets[0]
  user_data = file("${path.module}/app2-install.sh")
  tags = local.common_tags
}

#for_each = toset(["0", "1"])
 #name = "${var.environment}-PrivateVm-${each.key}"
 #name = "${var.environment}-PrivateVm"