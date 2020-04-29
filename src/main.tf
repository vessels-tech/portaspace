
/* Data Sources */

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_key_pair" "portaspace_key" {
  key_name   = "portaspace-key"
  # public_key = var.public_key
  public_key = file("/Users/ldaly/.ssh/id_rsa.pub")
}

//TODO: enable hibernation!
resource "aws_instance" "portaspace" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Owner = "lewis"
  }
  
  security_groups = [
    aws_security_group.whitelist_traffic.name
  ]

  associate_public_ip_address = true
  key_name = aws_key_pair.portaspace_key.key_name

  # TODO: Work on this script... make it bulletproof!
  user_data = file("${path.module}/userdata.sh")

  root_block_device {
    # size in GB
    volume_size = 150
    delete_on_termination = true

  }
}

resource "aws_security_group" "whitelist_traffic" {
  name        = "whitelist_traffic"
  description = "Whitelist traffic from certain IPs"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "All traffic from Lewis"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.whitelist_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_route53_record" "base" {
  zone_id = var.route_53_zone_id
  name    = var.record_name_base
  type    = "A"
  ttl     = "300"
  records = [
    aws_instance.portaspace.public_ip
  ]
}

/* Outputs */

output "instance_id" {
  value = aws_instance.portaspace.id
}

output "public_ip" {
  value = aws_instance.portaspace.public_ip
}

output "hostname" {
  value = var.record_name_base
}