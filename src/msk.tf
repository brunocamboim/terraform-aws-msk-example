data "aws_vpc" "main-vpc" {
  tags = {
    Name = "main-vpc"
  }
}

data "aws_subnet_ids" "subnets-private-main-vpc" {
  vpc_id = data.aws_vpc.main-vpc.id

  tags = {
    Tier = "private"
  }
}

data "aws_subnet" "subnets-private-main-vpc" {
  for_each = data.aws_subnet_ids.subnets-private-main-vpc.ids
  id       = each.value
}

resource "aws_cloudwatch_log_group" "msk_kafka_brokers_logs" {
  name = "msk_kafka_brokers_logs"
}

resource "aws_msk_cluster" "kafka_cluster" {
  cluster_name           = "kafka-cluster"
  kafka_version          = "2.2.1"
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type   = var.kafka_instance_type
    ebs_volume_size = 10
    client_subnets = [for s in data.aws_subnet.subnets-private-main-vpc : s.id] 
    security_groups = [aws_security_group.sg-apache-kafka-cluster.id]
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk_kafka_brokers_logs.name
      }
    }
  }

  depends_on = [
    aws_security_group.sg-apache-kafka-cluster,
    aws_cloudwatch_log_group.msk_kafka_brokers_logs
  ]

  tags = {
    Name  = "KafkaCluster"
    env   = var.env
    team  = var.team
  }
}