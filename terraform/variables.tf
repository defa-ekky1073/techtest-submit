variable "AWS_ACCESS_KEY" {
    type = string
}

variable "AWS_SECRET_KEY" {
    type = string
}

variable "AWS_REGION" {
    type = string
    default = "ap-southeast-1"
}

variable "AWS_VPC_SG" {
    type = list
    default = ["sg-bdc01bf0"]
}