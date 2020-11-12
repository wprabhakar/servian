resource "aws_db_instance" "db" {
    identifier                = "postgres"
    allocated_storage         = 5
    backup_retention_period   = 0
    // backup_window             = "01:00-01:30"
    // maintenance_window        = "sun:03:00-sun:03:30"
    // multi_az                  = false
    engine                    = "postgres"
    engine_version            = "10.7"
    instance_class            = "db.t2.micro"
    name                      = "app"
    username                  = "postgres"
    password                  = "changeme"
    port                      = "5432"
    db_subnet_group_name      = aws_db_subnet_group.db_subnet_group.id
    vpc_security_group_ids    = [aws_security_group.rds_sg.id, aws_security_group.ecs_sg.id]
    skip_final_snapshot       = true
}
