resource "aws_launch_configuration" "app-launchconfig" {
  name_prefix     = "app-launchconfig"
  image_id        = "ami-0c28d7c6dd94fb3a7"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.sg-instance.id]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app-autoscaling" {
  name                      = "app-autoscaling"
  vpc_zone_identifier       = [aws_subnet.app-vpc-public.id, aws_subnet.app-vpc-public-1.id]
  launch_configuration      = aws_launch_configuration.app-launchconfig.name
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.app-elb.name]
  force_delete              = true

  tag {
    key                 = "Ec2 instance"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}






















// resource "aws_instance" "instance" {
//   ami           = "ami-0c28d7c6dd94fb3a7"
//   instance_type = "t2.micro"

//   # the VPC subnet
//   subnet_id = aws_subnet.app-vpc-public.id

//   # the security group
//   vpc_security_group_ids = [aws_security_group.sg-instance.id]

//   # the public SSH key
//   key_name = aws_key_pair.deployer.key_name

//   tags ={
//     Name="instancePost"
//   }
// }