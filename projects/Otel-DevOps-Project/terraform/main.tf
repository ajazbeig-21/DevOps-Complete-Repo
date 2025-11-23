terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "demo-terraform-eks-state-s3-bucket"
    key = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-eks-state-locks"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
   vpc_cidr = var.vpc_cidr
   private_subnet_cidr = var.private_subnet_cidr
   public_subnet_cidr = var.public_subnet_cidr
   availability_zones = var.availability_zones

}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  node_group = {
    "demo-node-group" = {
        instance_types = ["t3.medium"]
        desired_capacity = 2
        scaling_config = {
            desired_capacity = 2
            min_size = 1
            max_size = 3
        }
    }
  }
}