from flask import redirect, request, render_template, flash, Response
from sqlalchemy import text
from util import validate_book, validate_article, create_bibtex
from repositories.reference_repository import create_book, create_article, update_book, update_article
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
    return render_template('show_reference.html', reference=reference, ref=ref, create_bibtex=create_bibtex) if reference else redirect('/')

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
        return render_template('new_reference.html', book_name=name, book_author=author, book_title=title,
                               book_year=year, book_editor=editor, book_publisher=publisher, book_note=note, selected='Kirja')
    
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
        return render_template('new_reference.html', article_name=name, article_author=author, article_title=title,
                               article_year=year, article_journal=journal, article_note=note, selected='Artikkeli')

@app.route('/reference/<string:ref_type>/<int:reference_id>/edit', methods=['GET', 'POST'])
def edit_reference(ref_type, reference_id):
    if request.method == 'POST':
        print(request.form)
        name = request.form.get('name')
        author = request.form.get('author')
        title = request.form.get('title')
        year = request.form.get('year')
        note = request.form.get('note')

        try:
            if ref_type == 'book':
                editor = request.form.get('editor')
                publisher = request.form.get('publisher')
                validate_book(author, title, year, editor, publisher, note)
                update_book(reference_id, name, author, title, year, editor, publisher, note)
            elif ref_type == 'article':
                journal = request.form.get('journal')
                validate_article(author, title, journal, year, note)
                update_article(reference_id, name, author, title, year, journal, note)
            return redirect(f'/reference/{ref_type}/{reference_id}')
        except Exception as error:
            flash(str(error))
            return redirect(f'/reference/{ref_type}/{reference_id}/edit')

    elif request.method == 'GET':
        if ref_type == 'book':
            sql = text('SELECT id, name, author, title, year, editor, publisher, note FROM books WHERE id = :id')
        elif ref_type == 'article':
            sql = text('SELECT id, name, author, title, year, journal, note FROM articles WHERE id = :id')

        query = db.session.execute(sql, {'id': reference_id})
        reference = query.fetchone()
        if not reference:
            return redirect('/')

        ref = ref_type
        return render_template('edit_reference.html', reference=reference, ref=ref)

@app.route('/download_bibtex')
def download_bibtex():
    sql_books = text("SELECT * FROM books")
    books = db.session.execute(sql_books).fetchall()

    sql_articles = text("SELECT * FROM articles")
    articles = db.session.execute(sql_articles).fetchall()

    bibtex_entries = []

    for book in books:
        book_ref = type('obj', (object,), {
            'name': book[1],
            'title': book[2],
            'author': book[3],
            'year': book[4],
            'editor': book[5],
            'publisher': book[6],
            'note': book[7]
        })()
        bibtex_entries.append(create_bibtex(book_ref, 'book'))

    for article in articles:
        article_ref = type('obj', (object,), {
            'name': article[1],
            'author': article[2],
            'title': article[3],
            'journal': article[4],
            'year': article[5],
            'note': article[6]
        })()
        bibtex_entries.append(create_bibtex(article_ref, 'article'))

    bibtex_content = '\n\n'.join(bibtex_entries)

    return Response(bibtex_content, mimetype='text/plain', headers={"Content-Disposition": "attachment;filename=references.bib"})

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
