from flask import Flask, redirect, request, flash
from util import validate_book
from repositories.reference_repository import create_book

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello World"

@app.route('/create_book', methods=["POST"])
def reference_creation():
    author = request.form.get("author")
    title = request.form.get("title")
    year = request.form.get("year")

    try:
        validate_book(author, title, year)
        create_book(author, title, year)
        return redirect("/")
    except Exception as error:
        flash(str(error))
        return redirect("/new_reference")
