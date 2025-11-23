variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group"{
    description = "Configuration for the EKS node group"
   type = map(object({
        instance_types = list(string)
        desired_capacity = number
        scaling_config= object({
            desired_capacity = number
            min_size = number
            max_size = number
    })
    }))
}