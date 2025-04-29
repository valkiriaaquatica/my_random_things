from flask import Flask, Response
import logging
app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

@app.route('/')
def handler():
    message = "Hello World"
    return Response(message, mimetype='text/plain')

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
