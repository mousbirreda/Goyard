variable "apim_name" {
  description = "Nom de l'APIM"
  type        = string
}

variable "location" {
  description = "Emplacement Azure pour le déploiement"
  type        = string
  default     = "West Europe"
}

# ... Ajoutez d'autres variables si nécessaire ...
