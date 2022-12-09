import socket

from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def index():
    host = socket.gethostname()
    ip = socket.gethostbyname(host)
    return f"Hello {request.remote_addr}, this is {ip}\n"

if __name__ == "__main__":
    app.run(host='0.0.0.0')

