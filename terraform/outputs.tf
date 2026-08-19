output "public_ip" {
  description = "IP publica de la instancia"
  value       = aws_instance.api_server.public_ip
}

output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.api_server.id
}