import socket
import json
import datetime
import http.server

class SimpleTimeServiceHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()

        response = {
            "timestamp": datetime.datetime.utcnow().isoformat(),
            "ip": self.client_address[0]
        }
        self.wfile.write(json.dumps(response).encode())

if __name__ == "__main__":
    server_address = ("0.0.0.0", 8080)
    httpd = http.server.HTTPServer(server_address, SimpleTimeServiceHandler)
    print("Starting server on port 8080...")
    httpd.serve_forever()
from http.server import BaseHTTPRequestHandler, HTTPServer
import json
from datetime import datetime

class SimpleHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/":
            response = {
                "timestamp": datetime.utcnow().isoformat(),
                "ip": self.client_address[0]
            }
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps(response).encode())
        else:
            self.send_response(404)
            self.end_headers()
