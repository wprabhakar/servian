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
        "containerPort": 3000,
        "protocol": "tcp"
      }
    ],
    "image": "${REPOSITORY_URL}:latest",
    "environment": [{
        "name": "DB_HOST",
        "value": "${DB_HOST}"
       }, {
        "name": "DB_PORT",
        "value": "${DB_PORT}" 
       }, {
        "name": "DB_NAME",
        "value": "${DB_NAME}" 
       }, {
        "name": "DB_USER",
        "value": "${DB_USER}" 
       }, {
        "name": "DB_PASSWORD",
        "value": "${DB_PASSWORD}" 
       }
    ],
    "entryPoint" : [
      "sh",
      "-c"
    ],
    "command": [
      "/bin/sh -c \"./TechChallengeApp updatedb -s  && ./TechChallengeApp serve\""
    ],
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
