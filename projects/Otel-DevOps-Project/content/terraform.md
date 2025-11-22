# Terraform Configuration for EKS VPC Setup

## Overview

Our application is deployed on an EKS cluster within a VPC. To ensure that users, customers, developers, and QA teams can access the application, we need to configure the network appropriately. The frontend application should be accessible from the internet, so it resides in a public subnet with an Internet Gateway (IGW). The EKS cluster itself is placed in a private subnet for security, using a NAT Gateway for outbound internet access.

### Key Components
- **VPC**: Virtual Private Cloud to isolate our resources.
- **Public Subnet**: Hosts the frontend application and is connected to the IGW for inbound and outbound internet traffic.
- **Private Subnet**: Hosts the EKS cluster and uses a NAT Gateway for outbound traffic, keeping internal IPs hidden.
- **Internet Gateway (IGW)**: Allows public subnet resources to communicate with the internet.
- **NAT Gateway**: Enables private subnet resources to access the internet for updates, etc., while masking their IP addresses.
- **Route Tables**: Define how traffic is routed within the VPC.

## Benefits
- **Security**: Private subnets protect internal resources from direct internet exposure.
- **IP Masking**: NAT Gateway hides private IP addresses, adding a layer of security.
- **Scalability**: Proper subnetting allows for better resource management.

## Steps to Configure in Terraform

1. **Create VPC Resource**: Define the VPC with appropriate CIDR blocks.
2. **Create Subnets**:
   - Public Subnet: Associate with IGW.
   - Private Subnet: Associate with NAT Gateway.
3. **Add Internet Gateway**: Attach to the VPC for public access.
4. **Add NAT Gateway**: Place in the public subnet to serve the private subnet.
5. **Configure Route Tables**:
   - Public Route Table: Route traffic from public subnet to IGW.
   - Private Route Table: Route traffic from private subnet to NAT Gateway.

## Architecture Flow Diagram

```mermaid
graph TD
    A[User/Customer] --> B[Internet Gateway (IGW)]
    B --> C[Public Subnet]
    C --> D[Frontend Application]
    E[Private Subnet] --> F[EKS Cluster]
    F --> G[NAT Gateway]
    G --> H[Internet]
    E --> G
    I[VPC] --> C
    I --> E
    I --> B
    I --> G
```

This diagram illustrates the flow: Users access the frontend via the IGW in the public subnet. The EKS cluster in the private subnet communicates outbound through the NAT Gateway.