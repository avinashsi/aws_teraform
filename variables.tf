variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}

# Amazon_Ami
variable "aws_amis" {
  default = {
    "us-west-2" = "ami-01e24be29428c15b2"
    }
}
