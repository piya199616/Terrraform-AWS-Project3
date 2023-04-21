# Terrraform-AWS-Project3
# REAL TIME Project

Today we will be deploying a 3-tier ALB Context Path-based Routing using Terraform in AWS.

Previously I have used SImple Application load balancer so this is an upgrade to project2.

AWS Services :- EC2 Instances, VPC, Nat Gateway , Internet Gateway, security groups, Application Load balancer,Route53 and ACM.

** So Here We will Deploy our Application in 2 Availability Zones **

Project Architecture

![project3](https://user-images.githubusercontent.com/98099702/233510239-4912b7da-c3c2-4763-b933-bdf657226586.jpg)

# What we will provision:

- 1 VPC,6 subnets (Public, Private, Database),1 Nat gateway in Public Subnet, 1 Internet Gateway attached to VPC.

- 1 Bastion host and 4 private EC2 instances in 2 AZs.

- 1 Application Load Balancer.

- 3 Security Groups (bastion host, Private Ec2, and Load balancer)

- Creating a Recording using Route53 and attaching ACM certicate .

- with the help of provisioner, we will copy the file from local(the private key file you copied) to the Bastion host, Run some commands on the remote host.






