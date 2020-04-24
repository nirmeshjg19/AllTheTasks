output "vpc_id" {
  value       = aws_vpc.app-vpc.id
}

output "public_subnet_id" {
  value       = aws_subnet.app-vpc-public.id
}

output "private_subnet_id" {
  value       = aws_subnet.app-vpc-private.id
}

output "private_subnet_id-1" {
  value       = aws_subnet.app-vpc-private.id
}

output "Internet_Gateway_id" {
  value       = aws_internet_gateway.app-vpc-gw.id
}

output "NAT_gateway_id" {
  value       = aws_nat_gateway.nat-gw.id
}

output "zookeeper_connect_string" {
  value = "${aws_msk_cluster.msk-demo.zookeeper_connect_string}"
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = "${aws_msk_cluster.msk-demo.bootstrap_brokers}"
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = "${aws_msk_cluster.msk-demo.bootstrap_brokers_tls}"
}
