variable "subscription_id" {
  type    = string
  default = ""
}

variable "client_id" {
  type    = string
  default = ""
}

variable "client_secret" {
  type    = string
  default = ""
}

variable "tenant_id" {
  type    = string
  default = ""
}

variable "resource_group_name" {
  type        = string
  description = "The default name is TFCloudRG007, Provide the Resource Group Name in terraform.tfvars file if any change needed."
  default     = "TFCloudRG"
}

variable "resource_group_location" {
  type        = string
  description = "The default location is West Europe, Provide the Resource Group location in terraform.tfvars file if any change needed."
  default     = "West Europe"
}

variable "vnet_name" {
  type        = string
  description = "The default Vnet_Name is vnet-tf, Provide the Virtual Network name in terraform.tfvars file if any change needed."
  default     = "vnet-tf"
}

variable "subnet_name" {
  type        = string
  description = "The default Subnet is subnet01, Provide the subnet name in terraform.tfvars file if any change needed."
  default     = "subnet01"
}

variable "public_ip" {
  type        = string
  description = "The default public IP is myPublicIP, Provide the Public IP name in terraform.tfvars file if any change needed."
  default     = "myPublicIP"
}

variable "network_security_group_name" {
  type        = string
  description = "The default Network Security Group name is TFC_NSG, Provide the NSG name in terraform.tfvars file if any change needed."
  default     = "TFC_NSG"
}

variable "azure_virtual_machine_name" {
  type        = string
  description = "The default VM name is TFCloudVM, Provide the VM name in terraform.tfvars file if any change needed."
  default     = "TFCloudVM"
}

variable "InstanceType" {
  type        = string
  description = "The default Instance Type is B1s, Provide the Instance Type in terraform.tfvars file if any change needed."
  default     = "Standard_B1s"
}

variable "admin_vm_username" {
  type        = string
  description = "The default VM admin user is adminuser, Provide the admin user name in terraform.tfvars file if any change needed."
  default     = "adminuser"
}

variable "admin_vm_password" {
  type        = string
  description = "The default VM admin password is *********, Provide the admin user password in terraform.tfvars file if any change needed."
  default = "Admin123"
}
