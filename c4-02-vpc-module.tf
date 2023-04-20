#Create VPC terraform Module

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"


  #VPC Basic Details


  name = "${local.name}-${var.vpc_name}"
  cidr = var.vpc_cidr_block

  azs             = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets  

  

  #Database subnets
  database_subnets = var.vpc_database_subnets
  create_database_subnet_group = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  #create_database_internet_gateway_route = false
  #create_database_nat_gateway_route = false

 #NAT Gateway for private subnet-Outbound COmmunication

  enable_nat_gateway = var.vpc_enable_nat_gateway 
  single_nat_gateway = var.vpc_single_nat_gateway


#VPC DNS Parameters
enable_dns_hostnames= true
enable_dns_support = true

public_subnet_tags = {
    Type = "public-subnets"
  }


private_subnet_tags = {
    name = "Private-subnet"
}

database_subnet_tags = {
    name= "database-subnet"
}



 tags = local.common_tags
 vpc_tags = local.common_tags


}