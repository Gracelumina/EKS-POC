resource "aws_eks_cluster" "poc" {
  name     = var.cluster-name
  role_arn = aws_iam_role.poc-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.poc-cluster.id]
    subnet_ids = module.vpc.public_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.poc-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.poc-cluster-AmazonEKSServicePolicy,
  ]
}

