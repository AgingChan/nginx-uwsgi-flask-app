from app.run import app, db, blueprint, api
from app.api import heartbeat, admin, faceId

db.init_app(app)

api.add_namespace(heartbeat, '/heartbeat')
api.add_namespace(admin, '/admin')
api.add_namespace(faceId, '/faceId')
app.register_blueprint(blueprint)

if __name__ == "__main__":
    app.run()
#
# from flask import Flask
# app = Flask(__name__)
#
#
# @app.route("/")
# def hello():
#     return "Hello World from Nginx-uwsgi-Flask"
#
#
# if __name__ == "__main__":
#     # Only for debugging while developing
#     app.run()
