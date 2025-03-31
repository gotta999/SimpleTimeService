provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "simple-time-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway    = true
  enable_dns_hostnames  = true
}

# ECS Cluster
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.0.0"

  cluster_name = "simple-time-cluster"
}

# ALB (Application Load Balancer)
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.0.0"

  name               = "simple-time-alb"
  load_balancer_type = "application"
  vpc_id            = module.vpc.vpc_id
  subnets           = module.vpc.public_subnets
}

# ECS Fargate Task Definition
resource "aws_ecs_task_definition" "simple_time_task" {
  family                   = "simple-time-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "512"
  cpu                      = "256"

  container_definitions = jsonencode([
    {
      name  = "simple-time-container"
      image = var.docker_image
      memory = 512
      cpu    = 256
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

# ECS Fargate Service
resource "aws_ecs_service" "simple_time_service" {
  name            = "simple-time-service"
  cluster        = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.simple_time_task.arn
  desired_count  = 1
  launch_type    = "FARGATE"

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs_sg.id]
  }
}

# Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
