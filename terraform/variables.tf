variable "aws_region" {
    type = string
    description = "Default AWS region"
    default = "ap-southeast-2"
}

variable "regions" {
    type = list(string)
    description = "List of AWS regions"
    default = ["eu-central-1", "ap-southeast-2"]
}

variable "environment" {
    type = string
    description = "Environment"
    default = "sandbox"
    validation {
        condition     = contains(["sandbox", "development", "stage", "production"], var.environment)
        error_message = "The environment must be one of: `sandbox`, `development`, `stage`, `production`."
    }
}

variable "cors_enabled" {
    type = bool
    description = "Enable CORS"
    default = true
}
