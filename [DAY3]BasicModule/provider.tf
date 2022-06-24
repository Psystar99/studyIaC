provider "aws" {
	access_key = var.access_key
 	secret_key = var.secret_key
 	region = var.region
}

variable "access_key" {
 	default = "^^^^"
}

variable "secret_key" {
 	default = "^^^^"
}

variable "region" {
	default = "ap-northeast-2"
}