#!/bin/bash
set -e

IMAGE_NAME="myapp:latest"
CONTAINER_NAME="myapp_test"
PORT=8080

echo "== Building Docker image =="
docker build -t $IMAGE_NAME .

echo "== Starting container =="
docker run -d --rm -p $PORT:8080 --name $CONTAINER_NAME $IMAGE_NAME

echo "Waiting 5 seconds for app to start..."
sleep 5

echo -e "\n=============================="
echo "== Smoke Test: API Endpoints =="
echo "=============================="

echo -e "\n== Home =="
curl -s http://localhost:$PORT/ | head -n 10

echo -e "\n== Health Check =="
curl -s http://localhost:$PORT/api/health

echo -e "\n== Tracks (limit=3) =="
curl -s "http://localhost:$PORT/api/tracks?limit=3"

echo -e "\n== Single Track (id=10) =="
curl -s "http://localhost:$PORT/api/tracks/10"

echo -e "\n== Search (artist='Eminem') =="
curl -s "http://localhost:$PORT/api/tracks/search?artist=eminem"

echo -e "\n== Summary Stats =="
curl -s http://localhost:$PORT/api/summary

echo -e "\n== Top Energy Tracks =="
curl -s http://localhost:$PORT/api/top-energy

echo -e "\n=============================="
echo "Stopping container..."
docker stop $CONTAINER_NAME

echo "Smoke test complete!"
