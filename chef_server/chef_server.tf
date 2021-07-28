data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = "peer.review.01-varun-sharma-bucket"
    key = "peer.review.01-network-state"
    region = var.region
  } 
}

locals {
    vars = {
      server_dns_name = "${var.route53_a_record_name}"
      chefserver_download_url = var.chefserver_download_url,
      chefserver_rpm_name = var.chefserver_rpm_name,
      chef_admin_user_name = var.chef_admin_user_name,
      chef_admin_user_display_name = var.chef_admin_user_display_name,
      chef_default_org_name = var.chef_default_org_name,
      chef_default_org_display_name = var.chef_default_org_display_name,
      chef_admin_user_password = var.chef_admin_user_password,
      chef_admin_user_email = var.chef_admin_user_email
    }
}

module "chefserver" {
  source = "../modules/instance"
  instance_count = 1
  ami = var.instance_ami
  instance_type = "t2.xlarge"
  key_name = data.terraform_remote_state.network_details.outputs.ssh_key_pair
  subnet_id = data.terraform_remote_state.network_details.outputs.public_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.chefserver_security_group_id_array

  my_user_data = templatefile("./install_chefserver.sh", local.vars)

  tags = {
    Name = var.server_prefix
    "X-Contact" = "Varun Sharma"
    "X-Dept" = "PS"
    "X-Production" = "No"
  }
  chef_policy_name = ""
}

resource "aws_eip" "chefserver_epi" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.chefserver.instance_id
  allocation_id = aws_eip.chefserver_epi.id
}

resource "aws_route53_record" "dns_record" {
  zone_id = var.host_zone_id
  name    = var.route53_a_record_name
  type    = "A"
  ttl     = "300"
  records = [aws_eip.chefserver_epi.public_ip]
}

# This null resource is added to keep terraform waited till chef-server is fully configured
resource "null_resource" "chefserver-config" {
  provisioner "remote-exec" {
    connection {
      host = var.route53_a_record_name
      type = "ssh"
      user = "ec2-user"
      agent = false
      private_key = file("/Users/sharmav/pem_keys/varun-chef-key.pem")
    }
    inline = [
      "while [ ! -f /tmp/chef_server_completion_signal ]; do sleep 2; done",
    ]
  }
  depends_on = [
    module.chefserver
  ]
}