variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "docker_image" {
  description = "Docker image URL for the container"
}
