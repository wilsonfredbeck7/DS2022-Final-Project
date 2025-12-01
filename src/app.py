import os
import pandas as pd
from flask import Flask, jsonify, request

app = Flask(__name__)

# Load dataset at startup
BASE_DIR = os.path.dirname(__file__)  # path to src/
CSV_PATH = os.path.join(BASE_DIR, "../assets/Spotify-2000.csv")
DF = pd.read_csv(CSV_PATH)


@app.get("/")
@app.get("/api/")
def home():
    return jsonify({
        "routes": [
            "/api/health",
            "/api/tracks",
            "/api/summary",
            "/api/top-energy",
            "/api/search"
        ],
        "note": "Use /api/tracks?limit=N to get the first N tracks, /api/search?q=name to search."
    })


@app.get("/api/health")
def health():
    return {"status": "ok"}, 200


@app.get("/api/tracks")
def tracks():
    """Return all tracks or first N using ?limit=."""
    limit = int(request.args.get("limit", 100))
    data = DF.head(limit).to_dict(orient="records")
    return jsonify(data)


@app.get("/api/summary")
def summary():
    """Return summary stats for key columns."""
    try:
        return {
            "avg_danceability": float(DF["Danceability"].mean()),
            "avg_energy": float(DF["Energy"].mean()),
            "avg_acousticness": float(DF["Acousticness"].mean()),
            "avg_popularity": float(DF["Popularity"].mean()),
        }
    except KeyError as e:
        return {"error": f"Missing column in CSV: {e}"}, 500


@app.get("/api/top-energy")
def top_energy():
    """Return top 20 highest-energy tracks."""
    top = DF.nlargest(20, "Energy")
    return jsonify(top.to_dict(orient="records"))


@app.get("/api/search")
def search():
    """Search by track or artist name."""
    q = request.args.get("q", "").strip().lower()
    if not q:
        return jsonify([])

    results = DF[
        DF['Title'].str.lower().str.contains(q) |
        DF['Artist'].str.lower().str.contains(q)
    ]

    return jsonify(results.head(50).to_dict(orient="records"))



# ... (existing imports)


# ... (existing imports)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
