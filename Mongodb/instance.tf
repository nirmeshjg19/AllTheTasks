 resource "aws_instance" "instance" {
   ami           = "ami-0c28d7c6dd94fb3a7"
   instance_type = "t2.micro"
   # the VPC subnet
   subnet_id = aws_subnet.app-vpc-public.id

   # the security group
  vpc_security_group_ids = [aws_security_group.sg-instance.id]

   # the public SSH key
  key_name = aws_key_pair.deployer.key_name

  tags ={
    Name="instancePost"
 }
 }