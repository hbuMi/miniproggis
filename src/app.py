from flask import redirect, request, render_template, flash
from sqlalchemy import text
from util import validate_book
from repositories.reference_repository import create_book
from config import app, test_env, db
from db_helper import reset_db


@app.route('/')
def index():
    sql_books = text("SELECT *, 'book' as type FROM books")
    query_books = db.session.execute(sql_books)
    items_books = query_books.fetchall()

    sql_articles = text("SELECT *, 'article' as type FROM articles")
    query_articles = db.session.execute(sql_articles)
    items_articles = query_articles.fetchall()

    references = []
    for item in items_books:
        reference = {'id': item[0], 'name': item[1], 'type': 'book'}
        references.append(reference)

    for item in items_articles:
        reference = {'id': item[0], 'name': item[1], 'type': 'article'}
        references.append(reference)

    references = sorted(references, key=lambda r: r['id'])   # viitteet järjestetty id:n mukaan

    return render_template('index.html', references=references)

@app.route('/new_reference')
def new():
    return render_template('new_reference.html')

@app.route('/reference/<string:ref_type>/<int:reference_id>')
def show_reference(ref_type, reference_id):
    if ref_type == 'book':
        sql = text('SELECT * FROM books WHERE id = :id')
    elif ref_type == 'article':
        sql = text('SELECT * FROM articles WHERE id = :id')

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
        validate_book(author, title, year, editor, publisher, note)
        create_book(name, author, title, year, editor, publisher, note)
        return redirect('/')
    except Exception as error:
        flash(str(error))
        return redirect('/new_reference')

@app.route('/search')
def search():
    query = request.args.get('query')
    results = []
    if query:
        sql = text("""
        SELECT id, title, 'book' as type
        FROM books
        WHERE title ILIKE :query
        UNION
        SELECT id, title, 'article' as type
        FROM articles WHERE title ILIKE :query
        ORDER BY title
        """)
        results = db.session.execute(sql, {"query": f"%{query}%"}).fetchall()
    return render_template('search.html', query=query, results=results)

@app.route('/reset_db')
def reset_database():
    if test_env:
        reset_db()
    return redirect('/')
