output "chefserver_vm_public_ip" {
  value = module.chefserver.*.public_ip
}
output "chefserver_public_eip" {
  value = aws_eip.chefserver_epi.public_ip
}
output "chefserver_dnsname" {
  value = aws_route53_record.dns_record.name
}