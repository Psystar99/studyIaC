module "apache"{
    source = "./apache"
    vpc_id = "vpc-06549cc4d67ff5402"
    server_ips = ["10.10.1.1", "10.10.2.2", "10.10.3.3"]
}