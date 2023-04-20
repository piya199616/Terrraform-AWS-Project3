# ACM Module - To create and Verify SSL Certificates

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.2"

  domain_name  = data.aws_route53_zone.mydomain.name 
  zone_id      = data.aws_route53_zone.mydomain.zone_id

#change your domain name
  subject_alternative_names = [
    "*.devopseasy.link"
    
  ]

  wait_for_validation = true

  tags = local.common_tags
    
}

# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "ACM Certificate ARN"
  value = module.acm.acm_certificate_arn
  
}