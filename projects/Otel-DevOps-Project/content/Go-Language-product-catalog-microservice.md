# Go Language Product Catalog Microservice

This document provides instructions for setting up, building, and running the Go-based product catalog microservice using Docker.

## Overview

The product catalog microservice is built using Go and containerized with Docker. This guide covers the multi-stage Docker build process, which is a best practice for creating secure, optimized container images.

## Prerequisites

Before building the microservice, ensure you have the following installed:

- Docker (for building and running containers)
- Go 1.22+ (for local development)

## Docker Build Process

The Dockerfile uses a multi-stage build approach for security and optimization:

1. **Build Stage**: Download dependencies and compile the Go application
2. **Release Stage**: Copy only the necessary artifacts to a minimal runtime image

This approach ensures the final image contains only what's needed to run the application, improving security and reducing image size.

## Dockerfile

```dockerfile
# Multi-stage build: First stage for building the Go application
FROM golang:1.22-alpine AS builder

# Set working directory in the container
WORKDIR /src/app

# Copy go.mod and go.sum files first (for better caching of dependencies)
COPY go.mod go.sum ./

# Download Go module dependencies
RUN go mod download

# Copy the source code from the current directory to the container
COPY . .

# Build the Go application binary
RUN go build -o product-catalog ./

# Second stage: Minimal runtime image
FROM alpine AS release

# Install ca-certificates for HTTPS requests (if needed)
RUN apk --no-cache add ca-certificates

# Set working directory for the application
WORKDIR /usr/src/app

# Copy product data (JSON files containing product information)
COPY ./products ./products

# Copy the compiled binary from the builder stage
COPY --from=builder /src/app/product-catalog ./

# Set environment variable for the service port
ENV PRODUCT_CATALOG_PORT 8088

# Define the entrypoint to run the application
ENTRYPOINT ["./product-catalog"]
```

## Building the Docker Image

Build the Docker image with your registry information:

```bash
docker build -t <docker-registry-username>/<docker-image>:<tag> .
```

Example:
```bash
docker build -t myregistry/product-catalog:v1.0 .
```

## Running the Service

Run the container:

```bash
docker run -p 8088:8088 <docker-registry-username>/<docker-image>:<tag>
```

The service will be available at `http://localhost:8088`.

## Configuration

The service can be configured using the following environment variable:

- `PRODUCT_CATALOG_PORT`: Port on which the service listens (default: 8088)

## Testing the Service

Once the service is running, you can test it by making HTTP requests:

```bash
# Check service health
curl http://localhost:8088/health

# Get product catalog
curl http://localhost:8088/products

# Get specific product
curl http://localhost:8088/products/123
```

## Local Development

For local development without Docker:

1. Install Go dependencies:
   ```bash
   go mod download
   ```

2. Run the application:
   ```bash
   go run .
   ```

3. Build locally:
   ```bash
   go build -o product-catalog ./
   ```

## Troubleshooting

### Common Issues

1. **Build failures**: Ensure `go.mod` and `go.sum` files are present and valid.

2. **Port conflicts**: Change the port mapping if 8088 is already in use:
   ```bash
   docker run -p 8089:8088 <image-name>
   ```

3. **Missing product data**: Ensure the `./products` directory exists with the required JSON files.

### Logs

View container logs:
```bash
docker logs <container_id>
```

## Security Benefits

Using multi-stage builds provides several security advantages:

- Only the compiled binary is included in the final image
- No source code or build tools are present in the runtime image
- Smaller attack surface
- Faster security scanning and updates

## Additional Resources

- [Go Docker Official Image](https://hub.docker.com/_/golang/)
- [Docker Multi-stage Builds](https://docs.docker.com/develop/dev-best-practices/)
- [Go Modules](https://go.dev/ref/mod)