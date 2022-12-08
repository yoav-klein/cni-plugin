
from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def index():
    return f"Hello, received request from {request.remote_addr}\n"

if __name__ == "__main__":
    app.run(host='0.0.0.0')

