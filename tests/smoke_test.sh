#!/bin/bash
set -e

IMAGE_NAME="myapp:latest"
CONTAINER_NAME="myapp_test"
PORT=8080


docker build -t $IMAGE_NAME .


docker run -d --rm -p $PORT:8080 --name $CONTAINER_NAME $IMAGE_NAME


echo "Waiting 5 seconds for app to start..."
sleep 5


echo "== Home =="
curl -s http://localhost:$PORT/ | head -n 5
echo -e "\n== Health =="
curl -s http://localhost:$PORT/health
echo -e "\n== Tracks (limit=3) =="
curl -s "http://localhost:$PORT/tracks?limit=3"
echo -e "\n== Summary =="
curl -s http://localhost:$PORT/summary
echo -e "\n== Top Energy =="
curl -s http://localhost:$PORT/top-energy
echo -e "\n== Search (Eminem) =="
curl -s "http://localhost:$PORT/search?q=eminem"

# 5. Stop container
docker stop $CONTAINER_NAME
