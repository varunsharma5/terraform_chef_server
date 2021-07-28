# Chef server installation and configuration 

## Following opeations would be performed by this Terraform code:
* Provision and VM (RHEL 8) with ami-id: ami-06a0b4e3b7eb7a300
* Install chef server into the server
* Confgure chef server

## Prerequisites
* AWS account with  valid `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
* Host zone id that will be used to create and `A record` to be used as publicaly accesilble FQDN for chef server
* RHEL8 ami-id (you can use ami-06a0b4e3b7eb7a300)

## Pre Installation steps
You can customize the installtion setting using variable file at `terraform_chef_server/chef_server/variables.tf`

## To get the server keys
Upon sucessful Chef Server installation and configuration, keys can be found at default home directory (`/home/ec2-user`)

## Following variables are used to successfully run the terraform code:
| Name         | Description                                                                                                        | Mandatory | Default Value         |   |
|--------------|--------------------------------------------------------------------------------------------------------------------|:---------:|-----------------------|---|
| instance_ami | Red Hat Enterprise Linux version 8 (HVM), EBS General Purpose (SSD) Volume Type To be used to create EC2 instance  |     Y     | ami-06a0b4e3b7eb7a300 |   |
| host_zone_id | To create a FQDN required for chef server                                                                          |     Y     | NA                    |   |
|              |                                                                                                                    |           |                       |   |