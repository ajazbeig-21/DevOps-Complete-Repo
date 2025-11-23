variable "aws_region" {
  default = "us-west-2"
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "private_subnet_cidr" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subnet_cidr" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "availability_zones" {
  description = "The availability zones for the subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "demo-eks-cluster"
}