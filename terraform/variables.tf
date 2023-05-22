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
}
