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
│   └── app.py              # Main Flask API
├── assets/                 # Diagrams, screenshots, images
│   └── architecture.png
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

## 3) How to Run (Docker)

### Docker

```bash
# Build Docker image
docker build -t spotify-api:latest .
```
```bash
# Run container
docker run --rm -p 8080:8080 --env-file .env.example spotify-api:latest
```
```bash
# Test API health
curl http://127.0.0.1:8080/api/health
```
Test API endpoints:  

Health check: 
```bash
curl http://127.0.0.1:8080/api/health 
```
Top 10 energy tracks: 
```bash
curl "http://127.0.0.1:8080/api/top-energy"
```
Search tracks by artist: 
```bash
curl "http://127.0.0.1:8080/api/search?q=coldplay"
```
Search tracks by title: 
```bash
curl "http://127.0.0.1:8080/api/search?q=yellow"
```

---

## 4) Design Decisions

Why Flask?  
Flask is lightweight, flexible, and integrates seamlessly with pandas. Alternatives like FastAPI or Django were considered, but Flask provided simplicity and faster setup for this dataset.

Trade-offs:  
Performance: Pandas works well for ~1k records but may slow on larger datasets.  
Complexity: Lightweight API reduces overhead but does not include full authentication or caching.  
Maintainability: Modular code allows easy expansion (e.g., adding new endpoints).

Security/Privacy:  
No sensitive data is stored.  
Input validation ensures API queries do not crash the server.  
.env.example provided; no secrets committed.

Ops Considerations:  
Logging handled via Flask default logging.  
Docker container ensures deterministic builds.  
Scaling to larger datasets would require database integration and caching.

---

## 5) Results & Evaluation

Sample Output: 
```text
[
  {"title":"Song A","artist":"Artist X","energy":0.95,"danceability":0.80},  
  {"title":"Song B","artist":"Artist Y","energy":0.92,"danceability":0.75}  
]
```

Validation / Tests:  
tests/smoke_test.sh contains simple curl-based tests for endpoints.  
Confirms correct JSON structure and response codes.



## 6) What’s Next

Support larger datasets with a database backend (PostgreSQL/MongoDB).  
Add authentication and user management for multi-user queries.  
Include additional analytics endpoints (tempo distribution, key statistics).  
Optional deployment to cloud with stable public URL.

---

## 7) Links

GitHub Repo: https://github.com/wilsonfredbeck7/DS2022-Final-Project  
Public Cloud App (optional): <INSERT-CLOUD-URL>

License: MIT (see LICENSE file)  
Dataset Attribution: Spotify Top 2000s Mega Dataset, [Kaggle](https://www.kaggle.com/datasets/iamsumat/spotify-top-2000s-mega-dataset)

Sample Output:

Top energy tracks example:

json
Copy code
[
  {"title":"Song A","artist":"Artist X","energy":0.95,"danceability":0.80},
  {"title":"Song B","artist":"Artist Y","energy":0.92,"danceability":0.75}
]
Validation / Tests:

tests/smoke_test.sh contains simple curl-based tests for endpoints.

Confirms correct JSON structure and response codes.

Screenshots:

7) What’s Next
Support larger datasets with a database backend (PostgreSQL/MongoDB).

Add authentication and user management for multi-user queries.

Include additional analytics endpoints (tempo distribution, key statistics).

Optional deployment to cloud with stable public URL.

8) Links
GitHub Repo: https://github.com/wilsonfredbeck7/DS2022-Final-Project