data "aws_instances" "web" {
    filter {
        name = "tag:Name"
        values = ["web_asg"]
    }
    depends_on = [aws_autoscaling_group.web_asg]
}

data "aws_subnet_ids" "web_subnets" {
    vpc_id = var.vpc_id
    filter {
        name = "tag:Name"
        values = ["*Public*"]
    }
}

resource "aws_security_group" "web_sg" {
	name = "web-sg"
	vpc_id = var.vpc_id
	ingress {
		description = "http"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	} 
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "web-sg"
	}
}

resource "aws_launch_configuration" "web_lc" {
	name_prefix = "web-lc-"
	instance_type = "t2.micro"
	image_id = "ami-0e4a9ad2eb120e054"
	security_groups = [aws_security_group.web_sg.id]
	user_data = <<-EOT
	#!/bin/bash
	cat >> ~/hosts << EOF
	%{for ip in var.server_ips}
    server ${ip}
    %{endfor}
	EOF
	EOT
	
	lifecycle {
		create_before_destroy = true
	}

	dynamic "ebs_block_device" {
		for_each = toset(var.disk)
		content {
			device_name = ebs_block_device.value
			volume_size = var.volume_size
			volume_type = var.volume_type
		}
	}
}

resource "aws_autoscaling_group" "web_asg" {
name_prefix = "web-asg-"
max_size = 10
min_size = 1
desired_capacity = 2
launch_configuration = aws_launch_configuration.web_lc.name
vpc_zone_identifier = data.aws_subnet_ids.web_subnets.ids
tag {
        key= "Name"
        value = "web-asg"
        propagate_at_launch = true
    }
    lifecycle {
        create_before_destroy = true
    }
}