variable "AWS_REGION" {
  type        = string
  description = "Região onde os recursos serão provisionados"
  default     = null 
}

variable "AWS_PROJECT" {
  type        = string
  description = "Projeto para identificação dos recursos"
  default     = null
}

variable "AWS_ENVIRONMENT" {
  type        = string 
  description = "Ambiente para identificação dos recursos"
  default     = null
}

variable "AWS_GROUP" {
  type        = string
  description = "Agrupamento para identificação dos recursos"
  default     = "null"
}
variable "AWS_VPCS" {
  type = list(object({
    NAME        = string
    CIDR_BLOCK  = optional(string)
    ENVIRONMENT = optional(string)
    PROJECT     = optional(string)
    GROUP       = optional(string)
  }))
  description = "Rede lógica na AWS"
}

variable "AWS_SUBNETS" {
  type = list(object({
    NAME              = string
    VPC               = string
    CIDR_BLOCK        = string
    AVAILABILITY_ZONE = optional(string)
    ENVIRONMENT       = optional(string)
    PROJECT           = optional(string)
    GROUP             = optional(string)
  }))
  description = "Subrede ou range de IPs da VPC"
}

variable "AWS_INTERNET_GATEWAYS" {
  type = list(object({
    NAME        = string
    VPC         = string
    ENVIRONMENT = optional(string)
    PROJECT     = optional(string)
    GROUP       = optional(string)
  }))
}

variable "AWS_ROUTE_TABLE" {
  type = list(object({
    NAME        = string
    VPC         = string
    ROUTES      = optional(object({
      CIDR_BLOCK              = string
      IPV6_CIDR_BLOCK         = optional(string)
      DESTINATION_PREFIX_LIST = optional(string)
      CARRIER_GATEWAY         = optional(string)
      CORE_NETWORK_ARN        = optional(string)
      EGRESS_ONLY_GATEWAY     = optional(string)
      VIRTUAL_PRIVATE_GATEWAY = optional(string)
      LOCAL_GATEWAY           = optional(string)
      INTERNET_GATEWAY        = optional(string)
      NAT_GATEWAY             = optional(string)
      PEER_CONNECTION         = optional(string)
    }))
    ENVIRONMENT = optional(string)
    PROJECT     = optional(string)
    GROUP       = optional(string)
  }))
}

variable "AWS_ROUTE_TABLE_ASSOCIATIONS" {
  type = list(object({
    SUBNET         = optional(string)
    GATEWAY        = optional(string)
    NAT_GATEWAY    = optional(string)
    ROUTE_TABLE    = string
  }))
}