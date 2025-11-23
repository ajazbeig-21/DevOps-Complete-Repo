variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  }

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}

variable "public_subnet_cidr" {
  description = "value"
  type = list(string)
}
variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}