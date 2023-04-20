# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  depends_on = [module.vpc,module.ec2_public]
  instance =  module.ec2_public.id
  vpc = true
  tags = local.common_tags  

  provisioner "local-exec" {
    command = "echo destroy time provisioner 'date' >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
    when = destroy #this block will only trigger at the time of destroy.
  }
}
