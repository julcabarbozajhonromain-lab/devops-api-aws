variable "aws_region" {
  description = "Region de AWS"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia (free tier)"
  default     = "t3.micro"
}