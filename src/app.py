from flask import redirect, request, render_template, flash
from sqlalchemy import text
from util import validate_book, validate_article
from repositories.reference_repository import create_book, create_article 
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

    books = []
    for item in items_books:
        reference = {'id': item[0], 'name': item[1], 'type': 'book'}
        books.append(reference)
    
    articles = []
    for item in items_articles:
        reference = {'id': item[0], 'name': item[1], 'type': 'article'}
        articles.append(reference)

    books = sorted(books, key=lambda r: r['id'])   # kirjat järjestetty id:n mukaan
    articles = sorted(articles, key=lambda r: r['id'])   # artikkelit järjestetty id:n mukaan

    return render_template('index.html', books=books, articles=articles)

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
    ref = ref_type
    return render_template('show_reference.html', reference=reference, ref=ref) if reference else redirect('/')

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
    
@app.route('/create_article', methods=['POST'])
def article_creation():
    name = request.form.get('name')
    author = request.form.get('author')
    title = request.form.get('title')
    year = request.form.get('year')
    journal = request.form.get('journal')
    note = request.form.get('note')

    try:
        validate_article(author, title, journal, year, note)
        create_article(name, author, title, year, journal, note)
        return redirect('/')
    except Exception as error:
        flash(str(error))
        return redirect('/new_reference')

@app.route('/reset_db')
def reset_database():
    if test_env:
        reset_db()
    return redirect('/')
