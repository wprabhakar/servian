data "template_file" "nginx_template" {
    template = file("nginx_task.json.tpl")
    vars = {
      CONTAINER_NAME = "${var.container_name}-nginx"
      LOG_GROUP = var.cloudwatch_group
    }
}