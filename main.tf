terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# 1. Security Group para las Instancias EC2
resource "aws_security_group" "mi-sg-instancias" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security group para las instancias EC2"
  vpc_id      = var.vpc_id

  # Regla de entrada para SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de entrada para HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida (permitir todo el trafico saliente)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mi-sg-instancias"
  }
}

# 2. Security Group para EFS (NFS puerto 2049)
resource "aws_security_group" "mi-sg-efs" {
  name        = "mi-security-group-terraform-efs"
  description = "Security group para el servicio EFS"
  vpc_id      = var.vpc_id

  # Regla de entrada para NFS (puerto 2049)
  ingress {
    description     = "NFS para EFS"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.mi-sg-instancias.id]
  }

  # Regla de salida para NFS (puerto 2049)
  egress {
    description = "NFS de salida"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mi-sg-efs"
  }
}

# Instancias EC2 (solo usan el primer Security Group)
resource "aws_instance" "mi-intancia-efs" {
  count                  = var.cantidad_instancias
  ami                    = var.ami_id
  instance_type          = var.tipo_instancia
  key_name               = var.nombre_llave
  vpc_security_group_ids = [aws_security_group.mi-sg-instancias.id]

  tags = {
    Name = "Mi instancia EFS - ${count.index + 1}"
  }
}
