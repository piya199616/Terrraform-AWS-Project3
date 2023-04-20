
# DNS Registration 
#create a Record set in route53
#terraform aws route53 record
#In aws we already have a domain name registered hence we have used data source

resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "apps.devopseasy.link"
  type    = "A"
  
  alias {
    name                   = module.alb.lb_dns_name  #dns name of ALB from output section
    zone_id                = module.alb.lb_zone_id #dns zoneid of ALB from output section
    evaluate_target_health = true
  }
}