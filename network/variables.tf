variable "aws_availability_zone" {
  default = "a"
}
variable "region" {
  default = "ap-south-1"
}
variable "private_subnet_cidr_clock" {
  default = "10.0.100.0/24"
}
variable "public_subnet_cidr_clock" {
  default = "10.0.1.0/24"
}
variable "vpc_name" {
  default = "varun-peer-review-vpc"
}
variable "public_subnet_name" {
  default = "varun-peer-review-public-subnet"
}
variable "private_subnet_name" {
  default = "varun-peer-review-public-subnet"
}
variable "igw_name" {
  default = "varun-peer-review-igw"
}
variable "route_table_name" {
  default = "varun-peer-review-route-table"
}
variable "security_group_name" {
  default = "varun-peer-review-security-group"
}
variable "key_name" {
  default = "varun-peer-review-vm-key"
}
