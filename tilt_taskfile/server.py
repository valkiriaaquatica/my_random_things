from flask import Flask, send_from_directory, jsonify
import mysql.connector

app = Flask(__name__, static_url_path="", static_folder=".")

db_config = {
    "host": "mysql", 
    "user": "root",
    "password": "rootpassword",
}

@app.route("/")
def index():
    return send_from_directory(".", "index.html")

@app.route("/query")
def query_db():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT SCHEMA_NAME FROM information_schema.schemata;")
        results = cursor.fetchall()
        cursor.close()
        conn.close()

        return jsonify({"databases": results})
    except Exception as e:
        return jsonify({"error": str(e)})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
