from flask import Flask
import os
import pymysql
from .routes import bp

def create_app():
    app = Flask(__name__)
    app.register_blueprint(bp)

    # Load MySQL configuration from environment variables
    MYSQL_HOST = os.environ.get('MYSQL_HOST')
    MYSQL_PORT = os.environ.get('MYSQL_PORT')
    MYSQL_USER = os.environ.get('MYSQL_USER')
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD')
    MYSQL_DATABASE = os.environ.get('MYSQL_DATABASE')

    # Database connection setup
    global connection
    connection = pymysql.connect(
        host=MYSQL_HOST,
        port=int(MYSQL_PORT),
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        database=MYSQL_DATABASE
    )

    return app
