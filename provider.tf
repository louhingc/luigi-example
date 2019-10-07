# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "luigi" {
  name        = "${var.email-address} luigi Security Group"
  description = "Accept incoming connections."

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.permitted_ips}"]
  }

  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["${var.permitted_ips}"]
  }
  vpc_id = "${var.vpcid}"
  tags   = "${merge(map("Name", "luigi SG"))}"
}

# Create a web server
resource "aws_instance" "luigi" {
  ami = "ami-6869aa05"
  instance_type = "t1.micro"
  key_name = "MySuseInstance"
  user_data = "${data.template_file.init.rendered}"
}
