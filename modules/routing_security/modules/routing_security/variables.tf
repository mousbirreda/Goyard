variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vpn_device_ip" {
  description = "Internal IP of your VPN device"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the association"
  type        = string
}
