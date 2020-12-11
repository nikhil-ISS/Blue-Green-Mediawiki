resource "aws_security_group" "ingress_sg" {
  name_prefix = "ingress_sg"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "ingress_sg"
  }
}


resource "aws_security_group_rule" "ingress_my_machine" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["203.212.218.79/32"]
  security_group_id = aws_security_group.ingress_sg.id

}

resource "aws_security_group_rule" "ingress_alb_sg" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.alb_ingress_sg.id
  security_group_id        = aws_security_group.ingress_sg.id

}

resource "aws_security_group_rule" "internet_outbound" {
  provider          = aws
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ingress_sg.id
  description       = "Internet outbound"
}


resource "aws_security_group" "alb_ingress_sg" {
  name_prefix = "alb_ingress_sg"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "alb_ingress_sg"
  }
}


resource "aws_security_group_rule" "ingress_to_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_ingress_sg.id

}

resource "aws_security_group_rule" "internet_outbound_alb" {
  provider          = aws
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_ingress_sg.id
  description       = "Internet outbound"
}



resource "aws_security_group" "rds_ingress_sg" {
  name_prefix = "rds_ingress_sg"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "rds_ingress_sg"
  }
}


resource "aws_security_group_rule" "ingress_to_rds" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ingress_sg.id
  security_group_id        = aws_security_group.rds_ingress_sg.id

}

resource "aws_security_group_rule" "internet_outbound_rds" {
  provider          = aws
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_ingress_sg.id
  description       = "Internet outbound"
}