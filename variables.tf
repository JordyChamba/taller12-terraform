# Region donde se crearan los recursos
variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "ID de la AMI"
  type        = string
  default     = "ami-09bf9dfeeb1e9adbc"
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.medium"
}

variable "nombre_llave" {
  description = "Nombre de la llave"
  type        = string
  default     = "mi-primera-llaves-jc"
}

variable "cantidad_instancias" {
  description = "Cantidad de instancias"
  type        = number
  default     = 2
}

variable "vpc_id" {
  description = "ID del VPC donde se creara el Security Group"
  type        = string
  default     = "vpc-0b4e3ec247ede4cc9"
}
