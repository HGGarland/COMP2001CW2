import json
from http.server import BaseHTTPRequestHandler, HTTPServer
import pyodbc

# Database connection setup
conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=dist-6-505.uopnet.plymouth.ac.uk;'
    'DATABASE=COMP2001_HGarland;'
    'UID=HGarland;'
    'PWD=VqwZ940+'
)
cursor = conn.cursor()

# HTTP Request Handler
class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/trails":
            # Fetch all trails
            cursor.execute("SELECT * FROM Trails")
            rows = cursor.fetchall()
            trails = [{"id": row[0], "name": row[1], "description": row[2], "created_by": row[3]} for row in rows]
            self._respond(200, trails)
        elif self.path.startswith("/trails/"):
            # Fetch specific trail by ID
            trail_id = self.path.split("/")[-1]
            cursor.execute("SELECT * FROM Trails WHERE id= ?", (trail_id,))
            row = cursor.fetchone()
            if row:
                trail = {"id": row[0], "name": row[1], "description": row[2], "created_by": row[3]}
                self._respond(200, trail)
            else:
                self._respond(404, {"error": "Trail not found"})
        else:
            self._respond(404, {"error": "Endpoint not found"})

    def do_POST(self):
        if self.path == "/trails":
            # Create a new trail
            content_length = int(self.headers['Content-Length'])
            post_data = json.loads(self.rfile.read(content_length))
            try:
                cursor.execute("INSERT INTO Trails (name, description, created_by) VALUES (?, ?, ?)",
                               (post_data["name"], post_data.get("description"), post_data["created_by"]))
                conn.commit()
                self._respond(201, {"message": "Trail created successfully"})
            except KeyError:
                self._respond(400, {"error": "Invalid input data"})
        else:
            self._respond(404, {"error": "Endpoint not found"})

    def do_PUT(self):
        if self.path.startswith("/trails/"):
            # Update trail by ID
            trail_id = self.path.split("/")[-1]
            content_length = int(self.headers['Content-Length'])
            put_data = json.loads(self.rfile.read(content_length))
            cursor.execute("SELECT * FROM Trails WHERE id= ?", (trail_id,))
            if cursor.fetchone():
                cursor.execute("UPDATE Trails SET name= ?, description= ?, created_by= ? WHERE id= ?",
                               (put_data["name"], put_data.get("description"), put_data["created_by"], trail_id))
                conn.commit()
                self._respond(200, {"message": "Trail updated successfully"})
            else:
                self._respond(404, {"error": "Trail not found"})
        else:
            self._respond(404, {"error": "Endpoint not found"})

    def do_DELETE(self):
        if self.path.startswith("/trails/"):
            # Delete trail by ID
            trail_id = self.path.split("/")[-1]
            cursor.execute("DELETE FROM Trails WHERE id= ?", (trail_id,))
            if cursor.rowcount > 0:
                conn.commit()
                self._respond(200, {"message": "Trail deleted successfully"})
            else:
                self._respond(404, {"error": "Trail not found"})
        else:
            self._respond(404, {"error": "Endpoint not found"})

    def _respond(self, status_code, data):
        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())

# Start the server
def run(server_class=HTTPServer, handler_class=RequestHandler, port=8000):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f"Server running on port {port}")
    httpd.serve_forever()

if __name__ == "__main__":
    run()
