resource "aws_launch_configuration" "ecs_launch_config" {
    image_id             = "ami-01308997d4554a2f3"
    iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
    security_groups      = [aws_security_group.ecs_sg.id]
    # var.ecs_cluster values should be used in user_data
    user_data            = "#!/bin/bash\necho ECS_CLUSTER=servian-dev >> /etc/ecs/ecs.config"
    instance_type        = "t2.micro"
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
    name                      = var.ecs_cluster
    vpc_zone_identifier       = aws_subnet.pub_subnet.*.id
    launch_configuration      = aws_launch_configuration.ecs_launch_config.name

    desired_capacity          = 1
    min_size                  = 1
    max_size                  = 2
    health_check_grace_period = 300
    health_check_type         = "EC2"
}
