

resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "asg-ubuntu"
  image_id                    = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ingress_sg.id]
  user_data                   = file("./B-G/user_data.sh")
  key_name                    = "TestTtgw"
  lifecycle {
    create_before_destroy = true
  }

}




resource "aws_autoscaling_group" "asg_config" {
  name                 = "asg-B"
  launch_configuration = aws_launch_configuration.launch_config.name
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = data.aws_subnet_ids.get_public_subnet_ids.ids
  target_group_arns    = toset([aws_lb_target_group.alb_tg.arn])
  lifecycle {
    create_before_destroy = true
  }
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "Blue"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Application"
        "value"               = "Mediawiki"
        "propagate_at_launch" = true
      },
    ]
  )
}