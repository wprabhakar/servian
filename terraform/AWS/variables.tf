variable "az_count" {
  description = "Number of Subnets"
  default = 2 
}

variable "cloudwatch_group" {
  description = "cloud watch group"
  default = "servian"
}

variable "ecs_cluster" {
  default = "servian-cluster"
}

// variable "app_family" {
//   default = "tasks-api-family"
// }

variable "container_name" {
  default = "servian"
}
