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

server = HTTPServer(("0.0.0.0", 5000), SimpleHandler)
print("SimpleTimeService running on port 5000...")
server.serve_forever()
