import psycopg2
import os
import logging
from flask import Flask, render_template
from prometheus_flask_exporter import PrometheusMetrics


app = Flask(__name__)
app.logger.setLevel(logging.INFO)
metrics = PrometheusMetrics(app)
metrics.info("app_info", "Helloworld", version="1.0.0")


def db_connection():
    conn = psycopg2.connect(host=os.environ['POSTGRES_HOST'], database=os.environ['DATABASE_NAME'],user=os.environ['DB_USER'], password=os.environ['DB_PASSWORD'])

    return conn

@app.route('/')

def index():
    conn = db_connection()
    cur = conn.cursor()
    cur.execute('SELECT * FROM hello')
    
    text = cur.fetchall()
    app.logger.info("Received something from the database!!")
    cur.close()
    conn.close()

    return render_template("index.html", db_text=text[0][0])


if __name__ == "__main__":
    
    app.run(host='0.0.0.0', port=5000)