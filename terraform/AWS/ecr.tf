resource "aws_ecr_repository" "worker" {
    name  = var.container_name
}