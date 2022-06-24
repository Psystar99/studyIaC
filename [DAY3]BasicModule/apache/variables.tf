variable "vpc_id" {
	default = "vpc-xxx"
}

variable "server_ips" {
    default = ["10.10.2.3","10.10.4.5"]
}

variable "disk" {
  default = ["/dev/xvdb","/dev/xvdc"]
}

variable "volume_size" {
  default = "10"
}

variable "volume_type" {
  default = "gp2"
}