resource "aws_ecs_task_definition" "api" {
  family                = "${var.container_name}-api"
  container_definitions = data.template_file.api_template.rendered
}