variable "bucket_name" {
    type = string
}

variable "bucket_acl" {
    type = string
}

variable "versioning_enable" {
    type = bool
}

variable "sse_algorithm" {
    type = string
    default = "AES256"
}

variable "lambda_name" {
    type = string
}

variable "lambda_description" {
    type = string
}

variable "lambda_handler" {
    type = string
}

variable "lambda_runtime" {
    type = string
    default = "python3.9"
}

variable "source_path" {
    type = string
}

variable "lambda_policies" {
    type = list(string)
}

variable "lambda_number_of_policies"{
    type = number
}