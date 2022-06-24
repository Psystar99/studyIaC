output public_ips {
  value = module.apache.public_ips
}
output private_ips {
    value = module.apache.private_ips
}
output web_subnets {
    value = module.apache.web_subnets
}