# Create a Null Resource and Provisioners

resource "null_resource" "name" {
  
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    host     = aws_eip.bastion_eip.public_ip
    private_key = file("privatekey/terraform-key.pem")
  }
  # Copies the terraform-key.pem file to /tmp/terraform-key.pem

  provisioner "file" {
    source      = "privatekey/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  # Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
     
      "sudo chmod 777 /tmp/terraform-key.pem"
    ]
  }

  # local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo VPC created on 'date' and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
    #when = destroy -->this block will only trigger at the time of destroy.
  }
#local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource i.e when=destroy)
  /* provisioner "local-exec" {
    command = "echo destroy time provisioner 'date' >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
    when = destroy #this block will only trigger at the time of destroy.
  }
  ## Local Exec Provisioner:  
 #by default the provisioner you created are creation time provisioners they are created during resource creation

 */

}