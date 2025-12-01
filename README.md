# DS2022 Final Project: Spotify Data API

## 1) Executive Summary

Problem:  
Quickly exploring and analyzing Spotify track data for the 2000s can be tedious using raw CSV files. Users want an easy API to browse, summarize, and search tracks.

Solution:  
A Flask-based API that exposes endpoints to explore Spotify data programmatically. Users can retrieve top-energy tracks, search by artist or title, and obtain summary statistics. The app is fully containerized with Docker for reproducible deployment.

---

## 2) System Overview

Course Concept(s):  
- Flask API development  
- Data analysis with Pandas  
- Containerization using Docker  
- Endpoint testing / smoke tests

Architecture Diagram:  
![Architecture Diagram](assets/Final-Project-Diagram.png)  
Browser or curl → Flask API (app.py) → Pandas on CSV data → JSON response

Data/Models/Services:  
Component: Spotify 2000s Track Dataset  
Source: Kaggle: [Spotify Top 2000s Mega Dataset](https://www.kaggle.com/datasets/iamsumat/spotify-top-2000s-mega-dataset)  
Size: ~1k tracks  
Format: CSV  
License: Kaggle dataset terms  

Columns include: Title, Artist, Genre, BPM, Energy, Danceability, Acousticness, Popularity

---

## 3) Project Structure

DS2022-Final-Project/  
├── src/                    # Application / library code  
│   └── app.py              # Main Flask API  
├── assets/                 # Diagrams, screenshots, images  
│   ├── Final-Project-Diagram.png  
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

---

## 4) How to Run (Local / Docker)

Build Docker image:  
docker build -t spotify-api:latest .

Run container:  
docker run --rm -p 5000:5000 --env-file .env.example spotify-api:latest

Test API endpoints:  
Health check: curl http://127.0.0.1:5000/api/health  
Top 10 energy tracks: curl http://127.0.0.1:5000/api/tracks/top-energy?n=10  
Search tracks by artist: curl "http://127.0.0.1:5000/api/tracks/search?artist=Coldplay"  
Search tracks by title: curl "http://127.0.0.1:5000/api/tracks/search?title=Yellow"

Optional: include a run.sh script for one-line build + run.

---

## 5) Design Decisions

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

## 6) Results & Evaluation

Sample Output:  
[
  {"title":"Song A","artist":"Artist X","energy":0.95,"danceability":0.80},  
  {"title":"Song B","artist":"Artist Y","energy":0.92,"danceability":0.75}  
]

Validation / Tests:  
tests/smoke_test.sh contains simple curl-based tests for endpoints.  
Confirms correct JSON structure and response codes.

Screenshots:  
![Sample API Response](./assets/screenshots/sample_response.png)

---

## 7) What’s Next

Support larger datasets with a database backend (PostgreSQL/MongoDB).  
Add authentication and user management for multi-user queries.  
Include additional analytics endpoints (tempo distribution, key statistics).  
Optional deployment to cloud with stable public URL.

---

## 8) Links

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