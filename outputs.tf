output "id_instancias" {
  description = "El ID de las instancias creadas"
  value       = aws_instance.mi-intancia-efs[*].id
}

output "cantidad_de_instancias" {
  description = "La cantidad de instancias creadas"
  value       = length(aws_instance.mi-intancia-efs)
}

output "ip_publica_instancias" {
  description = "IP publica de las instancias creadas"
  value       = aws_instance.mi-intancia-efs[*].public_ip
}

output "zonas_disponibilidad" {
  description = "Zonas de disponibilidad"
  value       = aws_instance.mi-intancia-efs[*].availability_zone
}

output "sg_instancias_id" {
  description = "ID del Security Group para las instancias EC2"
  value       = aws_security_group.mi-sg-instancias.id
}

output "sg_efs_id" {
  description = "ID del Security Group para EFS"
  value       = aws_security_group.mi-sg-efs.id
}
