#Get DNS Information from AWS Route53

data "aws_route53_zone" "mydomain" {
  #my registered domain name in aws
  name= "devopseasy.link"
  
}

#Output MyDomain Zone ID

output "mydomain_zoneid" {
  description = "Hosted Zone id of the desired Hosted Zone."
  value = data.aws_route53_zone.mydomain.zone_id
}

#Output MyDomain Zone name

output "mydomain_name" {
  description = "Hosted Zone name of the desired Hosted Zone."
  value = data.aws_route53_zone.mydomain.name
}

