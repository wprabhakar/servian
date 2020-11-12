resource "aws_ecs_task_definition" "nginx" {
  family                = "${var.container_name}-nginx"
  container_definitions = data.template_file.nginx_template.rendered
}