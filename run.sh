#!/bin/bash
docker build -t music-stats .
docker run --rm -p 8080:8080 --env-file .env.example music-stats

chmod +x run.sh

