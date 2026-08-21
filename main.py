import os
from flask import Flask, request

app = Flask(__name__)

@app.get("/")
def hello():
    """Return a friendly HTTP greeting."""
    who = request.args.get("who", default="World")
    return f"Hello {who}!\n"

if __name__ == "__main__":
    port = int(os.environ.get("PORT", "8080"))
    app.run(host="0.0.0.0", port=port, debug=False, use_reloader=False)
