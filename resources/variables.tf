variable "region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "assume_role" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
