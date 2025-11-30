# Spotify 2000s Track Explorer API

## 1) Executive Summary

**Problem:**  
Exploring raw CSV datasets of Spotify tracks from the 2000s is tedious and inefficient for music analysts or hobbyists. Users must manually filter, sort, and compute statistics, which can be error-prone and time-consuming.

**Solution:**  
This project provides a **Flask-based API** that exposes endpoints to query, filter, and analyze Spotify track data programmatically. Users can retrieve top-energy tracks, search by artist or title, and obtain summary statistics through simple HTTP requests. The API is containerized with Docker for easy deployment and reproducibility.

---

## 2) System Overview

**Course Concept(s) Used:**  
- **Flask API**: Built REST endpoints to interact with tabular data.  
- **Pandas**: Data processing and aggregation from CSV files.  

**Architecture Diagram:**  
 
![Architecture Diagram](./assets/Final-Project-Diagram.png)

**Project Structure**

```text
DS2022-Final-Project/
├── src/                    # Application / library code
│   ├── app.py              # Main Flask API
│   ├── data_processing.py  # Pandas CSV utilities
│   └── __init__.py
├── assets/                 # Diagrams, screenshots, images
│   ├── architecture.png
│   └── screenshots/
│       └── sample_response.png
├── tests/                  # Smoke/unit tests
│   └── smoke_test.sh
├── Spotify-2000.csv        # Dataset (seed/test data)
├── Dockerfile              # Docker container instructions
├── requirements.txt        # Python dependencies
├── .env.example            # Example environment variables (no secrets)
├── run.sh                  # Optional one-line launcher
├── README.md               # Project write-up
└── LICENSE                 # MIT license for code
```


**Data/Models/Services:**  
| Component | Source | Size | Format | License |
|-----------|--------|------|--------|---------|
| Spotify 2000s Track Dataset | Kaggle: [Spotify Top 2000s Mega Dataset](https://www.kaggle.com/datasets/iamsumat/spotify-top-2000s-mega-dataset) | ~1k tracks | CSV | Kaggle license |

---

## 3) How to Run (Local)

### Docker

```bash
# Build Docker image
docker build -t spotify-api:latest .

# Run container
docker run --rm -p 5000:5000 --env-file .env.example spotify-api:latest

# Test API health
curl http://localhost:5000/health

