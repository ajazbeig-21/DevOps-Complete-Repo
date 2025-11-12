# Python Language Recommendation Microservice

This document provides instructions for setting up, building, and running the Python-based recommendation microservice using Docker.

## Overview

The recommendation microservice is built using Python and containerized with Docker. This service provides product recommendations based on user behavior and preferences.

## Prerequisites

Before building the microservice, ensure you have the following installed:

- Docker (for building and running containers)
- Python 3.12+ (for local development)

## Dockerfile

```dockerfile
# Use Python 3.12 slim image based on Debian Bookworm as the base image
FROM python:3.12-slim-bookworm AS base

# Set working directory in the container
WORKDIR /usr/src/app

# Copy requirements file first (for better Docker layer caching)
COPY requirements.txt ./

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the application source code
COPY . .

# Define the entrypoint to run the recommendation server
ENTRYPOINT ["python", "recommendation_server.py"]
```

## Building the Docker Image

Build the Docker image:

```bash
docker build -t <docker-registry-username>/recommendation-service:<tag> .
```

Example:
```bash
docker build -t myregistry/recommendation-service:v1.0 .
```

## Running the Service

Run the container:

```bash
docker run -p 8080:8080 <docker-registry-username>/recommendation-service:<tag>
```

The service will be available at `http://localhost:8080`.

## Configuration

The service can be configured using environment variables. Common configurations include:

- `PORT`: Port on which the service listens (default: 8080)
- Database connection strings
- Recommendation algorithm parameters

## Dependencies

The service requires the following Python packages (defined in `requirements.txt`):

```txt
flask==2.3.3
requests==2.31.0
numpy==1.24.3
pandas==2.0.3
scikit-learn==1.3.0
# Add other dependencies as needed
```

## Testing the Service

Once the service is running, you can test it by making HTTP requests:

```bash
# Check service health
curl http://localhost:8080/health

# Get recommendations for a user
curl "http://localhost:8080/recommendations?user_id=123"

# Get recommendations for a product
curl "http://localhost:8080/recommendations?product_id=456"
```

## Local Development

For local development without Docker:

1. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the application:
   ```bash
   python recommendation_server.py
   ```

## Project Structure

```
recommendation-service/
├── Dockerfile
├── requirements.txt
├── recommendation_server.py
├── models/
│   ├── recommendation_model.py
│   └── data_processor.py
├── tests/
│   ├── test_recommendation.py
│   └── test_api.py
└── data/
    └── training_data.csv
```

## API Endpoints

The service exposes the following main endpoints:

- `GET /health` - Health check endpoint
- `GET /recommendations` - Get product recommendations
  - Query parameters: `user_id`, `product_id`, `limit`
- `POST /feedback` - Submit user feedback for recommendations

## Troubleshooting

### Common Issues

1. **Port conflicts**: Change the port mapping if 8080 is already in use:
   ```bash
   docker run -p 8081:8080 <image-name>
   ```

2. **Missing dependencies**: Ensure `requirements.txt` is properly formatted and all packages are available on PyPI.

3. **Memory issues**: Python applications can be memory-intensive. Ensure adequate resources:
   ```bash
   docker run --memory=1g <image-name>
   ```

### Logs

View container logs:
```bash
docker logs <container_id>
```

For local development, logs will be printed to the console.

## Performance Optimization

- Use Python's `gunicorn` for production deployments instead of the development server
- Implement caching for frequently requested recommendations
- Use async/await patterns for I/O operations
- Consider using PyPy instead of CPython for better performance

## Security Considerations

- Keep dependencies updated and scan for vulnerabilities
- Use environment variables for sensitive configuration
- Implement proper input validation
- Consider using HTTPS in production
- Regularly update the base Python image

## Additional Resources

- [Python Docker Official Image](https://hub.docker.com/_/python)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)