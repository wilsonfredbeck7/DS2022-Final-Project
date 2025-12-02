#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Build the image
echo "Building Docker image..."
docker build -t spotify-api .

# Run the container
echo "Starting container on port 8080..."
docker run --rm -p 8080:8080 --env-file .env.example spotify-api
