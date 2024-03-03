import time
import os

from flask import Flask
from flask import render_template

import redis

redis_host = os.getenv('REDIS_HOST')
redis_password = os.getenv('REDIS_PASSWORD')

app = Flask(__name__)

cache = redis.Redis(host=redis_host, password=redis_password, port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route("/")
def hello():
    count = get_hit_count()
    return render_template('index.html', count=count)
