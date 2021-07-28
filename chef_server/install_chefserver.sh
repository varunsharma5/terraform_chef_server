#! /bin/bash
sudo su - 

# installing wget
yum install -y wget

# The Chef Infra Server does not have a profile available to run under SELinux. In order for the Chef Infra Server to run, SELinux must be disabled or set to 	Permissive mode
setenforce Permissive

# To confgure hostname
echo " ################################################# CONFIGURING HOST NAME: ${server_dns_name} #################################################"
hostname ${server_dns_name}
echo ${server_dns_name} | sudo tee /etc/hostname

# Download and install chef server package
echo ' ################################################# DOWNLOADING CHEF SERVER PACKAGE #################################################'
wget ${chefserver_download_url}
echo ' ################################################# INSTALLING CHEF SERVER PACKAGE #################################################'
sudo rpm -Uvh ${chefserver_rpm_name}

# Reconfigure chef-server
echo ' ################################################# START: RECONFIGURING CHEF SERVER #################################################'
chef-server-ctl reconfigure --chef-license=accept
echo ' ################################################# COMPLETED: RECONFIGURING CHEF SERVER #################################################'

sleep 30s

# Create admin user
echo ' ################################################# CREATING ADMIN USER #################################################'
echo " commnad : chef-server-ctl user-create ${chef_admin_user_name} ${chef_admin_user_display_name} '${chef_admin_user_email}' '${chef_admin_user_password}' --filename '/home/ec2-user/${chef_admin_user_name}.pem' "
chef-server-ctl user-create ${chef_admin_user_name} ${chef_admin_user_display_name} '${chef_admin_user_email}' '${chef_admin_user_password}' --filename /home/ec2-user/${chef_admin_user_name}.pem

# Create an organization
echo ' ################################################# CREATING DEFAULT ORG #################################################'
echo " create org command: sudo chef-server-ctl org-create '${chef_default_org_name}' '${chef_default_org_display_name}' --association_user ${chef_admin_user_name} --filename '/home/ec2-user/${chef_default_org_name}-validator.pem' "
chef-server-ctl org-create ${chef_default_org_name} "${chef_default_org_display_name}" --association_user ${chef_admin_user_name} --filename /home/ec2-user/${chef_default_org_name}-validator.pem

# Update a Chef Infra Server’s SSL using manual way
echo ' ################################################# UPDATING CHEF SERVER SSL #################################################'
cp "/var/opt/opscode/nginx/ca/${server_dns_name}.crt" "/etc/pki/tls/certs/${server_dns_name}.crt"
cp "/var/opt/opscode/nginx/ca/${server_dns_name}.key" "/etc/pki/tls/private/${server_dns_name}.key"

chef-server-ctl reconfigure --chef-license=accept

echo ' ################################################# RESTARTING NGINX #################################################'
chef-server-ctl restart nginx

echo '###############################################################################################################################################'
echo '################################################# CHEF SERVER INSTALLATION COMPLETED !!!!!!! ##################################################'
echo '###############################################################################################################################################'

touch /tmp/chef_server_completion_signal