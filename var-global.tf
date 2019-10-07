# aws creds
variable "aws_access_key" {
	default="AKIAJDX3E2G5Y7HIRSPQ"
}

variable "aws_secret_key" {
	default="py/WVER6c3QtSVtvAPFk9SaRJt6SFgvyXPruHXFx"
}

variable "aws_account_id" {
	default="450225760994"
}

variable "region" {
  default = "us-east-1"
}

variable "vpcid" {
  default = "vpc-e1b1e084"
}

variable "subnetid" {
  default = "subnet-f1f89a86"
}

variable "permitted_ips" {
  default = ["92.239.177.161/32"]
}

variable "host-iam-role" {
  default = "EC2Access"
}

variable "email-address" {}

data "template_file" "init" {
  template = "${file("${path.module}/init.tpl")}"
}
