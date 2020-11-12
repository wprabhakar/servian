resource "aws_ecs_service" "worker" {
  name            = "${var.container_name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 1
  // launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.api_task.id
    container_name   = "${var.container_name}-api"
    container_port   = 3000
  }
}

resource "aws_ecs_service" "nginx" {
  name            = "${var.container_name}-nginx"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 1
  // launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.nginx_task.id
    container_name   = "${var.container_name}-nginx"
    container_port   = 8080
  }
}
