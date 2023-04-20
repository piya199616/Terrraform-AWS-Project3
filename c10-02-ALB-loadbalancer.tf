module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.5.0"

  name = "${local.name}-alb"

  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0],module.vpc.public_subnets[1]]
  security_groups    = [aws_security_group.loadbalancer_sg.id]

 

  #Listener

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

#Target Group for App1

target_groups = [
    # App1 Target Group - TG Index = 0
    {
      name_prefix      = "app1-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }      
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private_app1[0].id
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private_app1[1].id
          port      = 80
        }        
      }
      tags = local.common_tags # Target Group Tags
    } ,  

    #  App2 Target Group - TG Index = 1
     {
      name_prefix      = "app2-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }      
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private_app2[0].id
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private_app2[1].id
          port      = 80
        }        
      }
      tags = local.common_tags # Target Group Tags
    } ,  

  ]

  #HTTPS Listener

#Associate SSL Certificate ARN
#Add fixed response for Root Context /*

  https_listeners = [
    # HTTPS Listener Index = 0 for HTTPS 443
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.acm_certificate_arn
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }
    }, 
  ]
  #HTTPS Listener Rules
 https_listener_rules = [
    # Rule-1: /app1* should go to App1 EC2 Instances
    { 
      https_listener_index = 0  #As we have defined only one https listener rule
      actions = [
        {
          type               = "forward"
          target_group_index = 0      #route to app1
        }
      ]
      conditions = [{
        path_patterns = ["/app1*"]
      }]
    },
    # Rule-2: /app2* should go to App2 EC2 Instances    
    {
      https_listener_index = 0  #As we have defined only one https listener rule
      actions = [
        {
          type               = "forward"
          target_group_index = 1  #route to app2
        }
      ]
      conditions = [{
        path_patterns = ["/app2*"]
      }]
    },    
  ]

  tags = local.common_tags
}



