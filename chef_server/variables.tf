variable "region" {
  default = "ap-south-1"
}
variable "instance_count_chefserver" {
  default = "1"
}
# Red Hat Enterprise Linux version 8 (HVM), EBS General Purpose (SSD) Volume Type
variable "instance_ami" {
  default = "ami-06a0b4e3b7eb7a300"
}
variable "server_prefix" {
  default = "varun_peer_review-chefserver-vm"
}
# Hosted Zone: varun.chefsuccess.io
variable "host_zone_id" {
  default = "Z085947422RTR2LQUT9Q"
}

variable "route53_a_record_name" {
  default = "server14.varun.chefsuccess.io"
}

# Below variables are used for installing and configuring chef server
variable "chefserver_download_url" {
  default = "https://packages.chef.io/files/stable/chef-server/14.5.29/el/8/chef-server-core-14.5.29-1.el7.x86_64.rpm"
}

variable "chefserver_rpm_name" {
  default = "chef-server-core-14.5.29-1.el7.x86_64.rpm"
}

variable "chef_admin_user_name" {
  default = "varun"
}

variable "chef_admin_user_display_name" {
  default = "VARUN SHARMA"
}

variable "chef_admin_user_email" {
  default = "varun.sharma@progress.com"
}

variable "chef_admin_user_password" {
  default = "Varun1234"
}

variable "chef_default_org_name" {
  default = "varun-org"
}

variable "chef_default_org_display_name" {
  default = "Varun Tech Inc."
}