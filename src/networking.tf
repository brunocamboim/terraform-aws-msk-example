resource "aws_security_group" "sg-apache-kafka-cluster" {
  name        = "sg_apache_kafka_cluster"
  description = "Allow access to kafka cluster"
  vpc_id      = data.aws_vpc.main-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "KafkaCluster"
    env   = var.env
    team  = var.team
  }
}