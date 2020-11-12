output "db_endpoint" {
    value = aws_db_instance.db.endpoint
}

output "ecr_ep" {
    value = aws_ecr_repository.worker.repository_url
}

output "loadbalancer_ep" {
    value = aws_alb.main.dns_name
}
