[
  {
    "essential": true,
    "memory": 100,
    "name": "${CONTAINER_NAME}",
    "networkMode": "awsvpc", 
    "executionRoleArn": "arn:aws:iam::REPLACE_ACCOUNT:role/ecsTaskExecutionRole",
    "cpu": 256,
    "portMappings": [
      {
        "hostPort": 0,
        "containerPort": 8080,
        "protocol": "tcp"
      }
    ],
    "image": "nginx:alpine",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${LOG_GROUP}",
        "awslogs-region": "ap-southeast-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
