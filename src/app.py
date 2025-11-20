from flask import redirect, request, render_template
from util import validate_book
from repositories.reference_repository import create_book
from config import app, test_env, db
from sqlalchemy import text


@app.route('/')
def index():
    sql = text('SELECT * FROM sources')
    query = db.session.execute(sql)
    items = query.fetchall()
    references = []
    for item in items:
        reference = {'id': item[0], 'name': item[1]}
        references.append(reference)

    return render_template('index.html', references=references)

@app.route('/new_reference')
def new():
    return render_template('new_reference.html')

@app.route('/reference/<int:reference_id>')
def show_reference(reference_id):
    sql = text('SELECT * FROM sources WHERE id = :id')
    query = db.session.execute(sql, {'id': reference_id})
    reference = query.fetchone()
    return render_template('show_reference.html', reference=reference) if reference else redirect('/')

@app.route('/create_book', methods=['POST'])
def book_creation():
    name = request.form.get('name')
    author = request.form.get('author')
    title = request.form.get('title')
    year = request.form.get('year')
    editor = request.form.get('editor')
    publisher = request.form.get('publisher')
    note = request.form.get('note')

    try:
        validate_book(author, title, year)
        create_book(name, author, title, year, editor, publisher, note)
        return redirect('/')
    except Exception as error:
        print(error)
        return redirect('/new_reference')
