output "public_ips"{
    value = data.aws_instances.web.public_ips
}
output "private_ips"{
    value = data.aws_instances.web.private_ips
}
output "web_subnets" {
    value = data.aws_subnet_ids.web_subnets.ids
}