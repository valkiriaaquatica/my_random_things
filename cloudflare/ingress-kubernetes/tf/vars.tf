variable "zone_id" {
    description = "The ID of the zone to manage."
    type        = string
    default    = "your_zone_id_here"
}

variable "account_id" {
    description = "The ID of the account to manage"
    type        = string
    default     = "your_account_id_here"
}

variable "app_domain" {
    description = "The domain of the aplication"
    type        = string
    default     = "your_domain_here"
  
}

variable "app_name" {
    description = "The name of the application"
    type        = string
    default     = "wordpress-test-admin"
}