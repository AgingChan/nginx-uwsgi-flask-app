# from app.run import app


# if __name__ == "__main__":
#     app.run()

from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World from Nginx-uwsgi-Flask"

if __name__ == "__main__":
    # Only for debugging while developing
    app.run()