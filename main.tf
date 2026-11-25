provider "aws" {
  region = "us-east-1"
}

# Security Group para EFS (NFS puerto 2049)
resource "aws_security_group" "mi-sg-efs-instancias-14" {
  name        = "mi-security-group-terraform-efs"
  description = "Security group para el servicio EFS"
  vpc_id      = "vpc-0b4e3ec247ede4cc9"
}

# Instancias EC2 (solo usan el primer Security Group)
resource "aws_security_group" "mi-sg-efs-14" {
  name        = "mi-security-group-terraform-efs-14"
  description = "Security group para el servicio EFS"
  vpc_id      = "vpc-0b4e3ec247ede4cc9"
}

# Reglas SG instancias
# Entrada
# entrada SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias-14" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

# Salida
# Salida a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_EFS-14" {
  security_group_id            = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol                  = "tcp"
  from_port                    = 2049
  to_port                      = 2049
  # Destino
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
}

# Salida a Internet, all trafic
resource "aws_vpc_security_group_egress_rule" "salida_internet-14" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "-1"
  # Destino
  cidr_ipv4         = "0.0.0.0/0"
}

# Reglas SG EFS
# Entrada
# Regla entrada EFS 2049
resource "aws_vpc_security_group_ingress_rule" "entrada_EFS-14" {
  security_group_id            = aws_security_group.mi-sg-efs-14.id
  ip_protocol                  = "tcp"
  from_port                    = 2049
  to_port                      = 2049
  # Origen
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
}

# Salida
# No se requiere reglas de salida