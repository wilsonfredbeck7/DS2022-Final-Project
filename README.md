# DS2022 Final Project: Spotify Data API

## 1) Executive Summary

**Problem:** Quickly exploring and analyzing Spotify track data for the 2000s can be tedious using raw CSV files. Users want an easy API to browse, summarize, and search tracks.

**Solution:** A Flask-based API that exposes multiple endpoints for exploring Spotify data, including track lists, summary statistics, top-energy tracks, and search by title/artist. The app is fully containerized with Docker for reproducible deployment.

---

## 2) System Overview

**Course Concept(s):**  
- Flask API development  
- Data analysis with Pandas  
- Containerization using Docker  
- Endpoint testing / smoke tests

**Architecture Diagram:**  
![Architecture](assets/architecture.png)  
- Browser or curl → Flask API (`app.py`) → Pandas on CSV data → JSON response

**Data/Models/Services:**  
- Dataset: `Spotify-2000.csv`  
- Format: CSV, ~1k tracks  
- Columns include Title, Artist, Genre, BPM, Energy, Danceability, Acousticness, Popularity  
- License: Public dataset (attribute as needed)

---

## 3) How to Run (Local / Docker)

**Build the Docker image:**
```bash
docker build -t spotify-api:latest .
