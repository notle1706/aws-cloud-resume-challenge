variable "aws_region" {
    description = "AWS Region"
    type =  string
}

variable "s3_bucket_name" {
    description = "Name of the S3 bucket"
    type =  string
}

variable "aws_access_key" {
    description = "AWS access key"
    type = string
    sensitive = true
}

variable "aws_secret_key" {
    description = "AWS secret key"
    type = string
    sensitive = true
}