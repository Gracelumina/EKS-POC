resource "aws_security_group" "poc-cluster" {
  name        = "terraform-eks-poc-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-poc"
  }
}

resource "aws_security_group_rule" "poc-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.poc-cluster.id
  source_security_group_id = aws_security_group.poc-node.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "poc-cluster-ingress-workstation-https" {
  cidr_blocks       = ["10.0.0.0/8",]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.poc-cluster.id
  to_port           = 443
  type              = "ingress"
}

