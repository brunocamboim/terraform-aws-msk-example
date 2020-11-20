output "zookeeper_connect_string" {
  value = aws_msk_cluster.plataforma_kafka_cluster.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.plataforma_kafka_cluster.bootstrap_brokers_tls
}