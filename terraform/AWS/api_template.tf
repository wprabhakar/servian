data "template_file" "api_template" {
    template = file("api_task.json.tpl")
    vars = {
      REPOSITORY_URL = replace(aws_ecr_repository.worker.repository_url, "https://", "")
      CONTAINER_NAME = "${var.container_name}-api"
      DB_HOST = split(":",aws_db_instance.db.endpoint).0
      DB_PORT = aws_db_instance.db.port
      DB_NAME = aws_db_instance.db.name
      DB_USER = aws_db_instance.db.username
      DB_PASSWORD = aws_db_instance.db.password
      LOG_GROUP = var.cloudwatch_group
    }
}