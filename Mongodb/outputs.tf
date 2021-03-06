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

output "Cluter-ndpoint"{
value         = aws_docdb_cluster.app-mongo-docdb.endpoint
}

