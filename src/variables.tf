provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = "~> 3.0"
  }

  backend "s3" {
    encrypt = true
    bucket  = "terraform-remotestate-dev"
    region  = "us-east-1"
    key     = "kafka-state"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "env" {
  default = "dev"
}

variable "team" {
  default = "PlataformaA"
}

variable "kafka_instance_type" {
  default = "kafka.t3.small"
}

variable "vpc_cidr_block" {
  default = "10.110.0.0/16"
}