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

variable "AWS_DYNAMODB_TABLES" {
  type = list(object({
    NAME           = string
    PROJECT        = optional(string)
    ENVIRONMENT    = optional(string)
    GROUP          = optional(string)
    HASH_KEY       = string
    ATTRIBUTE      = object({
      NAME = string
      TYPE = string
    })
    READ_CAPACITY  = optional(string)
    WRITE_CAPACITY = optional(string)
  }))
  description = "Tabela DynamoDB para state locking e checagem de consistência"
}

variable "AWS_KMS_KEYS" {
  type = list(object({
    NAME                    = optional(string)
    PROJECT                 = optional(string)
    ENVIRONMENT             = optional(string)
    GROUP                   = optional(string)
    DESCRIPTION             = optional(string)
    DELETION_WINDOW_IN_DAYS = optional(string)
    ENABLE_KEY_ROTATION     = optional(string)
  }))
  description = "Serviço para gerenciar chaves para criptografar dados na AWS"
}

variable "AWS_KMS_KEY_ALIASES" {
  type = list(object({
    NAME          = optional(string)
    NAME_PREFIX   = optional(string)  
    TARGET_KEY_ID = string
  }))
  description = "Alias para a KMS Key"
}

variable "AWS_S3_BUCKETS" {
  type = list(object({
    NAME        = string
    PROJECT     = optional(string)
    ENVIRONMENT = optional(string)
    GROUP       = optional(string)
    BLOCK       = optional(object({
      BLOCK_PUBLIC_ACLS       = string
      BLOCK_PUBLIC_POLICYS    = string
      IGNORE_PUBLIC_ACLS      = string
      RESTRICT_PUBLIC_BUCKETS = string
    }))
    VERSIONING  = optional(object({
      STATUS = string
    }))
    ENCRYPTION  = optional(object({
      SSE_ALGORITHM = string
      KEY           = string
    }))
  }))
}