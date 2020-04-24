resource "aws_security_group" "allow-traffic" {
  vpc_id      = aws_vpc.app-vpc.id
  name        = "traffic"
 
  ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    from_port       = 9092
    to_port         = 9092
    protocol        = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 2888
    to_port         = 2888
    protocol        = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 3888
    to_port         = 3888
    protocol        = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "allow-traffic"
  }
}