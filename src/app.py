from flask import redirect, request, render_template, flash, Response
from sqlalchemy import text
from util import validate_book, validate_article, create_bibtex, validate_doi_fields
from repositories.reference_repository import create_book, create_article, update_book, update_article
from config import app, test_env, db
from db_helper import reset_db
from doi import get_bibtex_from_doi
from bibtex import parse_bibtex

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

@app.route('/fill_from_doi', methods=['POST'])
def fill_from_doi():
    doi = request.form.get('doi')
    data = get_bibtex_from_doi(doi)
    try:
        data_dict = parse_bibtex(data)
    except Exception as error:
        flash(str(error))
        return render_template('new_reference.html')

    if data_dict["ENTRYTYPE"].lower() == "article":
        fields = ["author", "title", "year", "journal"]
        filled = validate_doi_fields(data_dict, fields)
        return render_template('new_reference.html', article_author=filled["author"], article_title=filled["title"],
                               article_year=filled["year"], article_journal=filled["journal"], selected='Artikkeli')

    fields = ["author", "title", "year", "editor", "publisher"]
    filled = validate_doi_fields(data_dict, fields)
    return render_template('new_reference.html', book_author=filled["author"], book_title=filled["title"],
                            book_year=filled["year"], book_editor=filled["editor"], book_publisher=filled["publisher"], selected='Kirja')

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
    
@app.route('/delete_all_references')
def delete_all_references():
    db.session.execute(text("DELETE FROM books"))
    db.session.execute(text("DELETE FROM articles"))
    db.session.commit()
    return redirect('/')

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
    mindate = request.args.get('mindate') or 0      # vuodet asetetaan min ja max arvoiksi jos ei ole syötettä
    maxdate = request.args.get('maxdate') or 2025
    author = request.args.get('author')

    results = []
    if query or author or mindate or maxdate:
        sql = text("""
        SELECT id, title, year, author, 'book' as type
        FROM books
        WHERE title ILIKE :query
        AND
        CASt(year AS integer) BETWEEN :mindate AND :maxdate
        AND
        author ILIKE :author
        UNION
        SELECT id, title, year, author, 'article' as type
        FROM articles 
        WHERE title ILIKE :query
        AND
        CASt(year AS integer) BETWEEN :mindate AND :maxdate
        AND
        author ILIKE :author
        ORDER BY title
        """)
        results = db.session.execute(sql, {"query": f"%{query}%", "mindate": mindate, "maxdate": maxdate, "author": f"%{author}%"}).fetchall()
    return render_template('search.html', query=query, author=author, mindate=mindate, maxdate=maxdate, results=results)

@app.route('/reset_db')
def reset_database():
    if test_env:
        reset_db()
    return redirect('/')

@app.route('/delete_selected', methods=['POST'])
def delete_selected():
    """Delete selected articles and books."""
    selected = request.form.getlist('selected')
    
    if not selected:
        flash('Valitse vähintään yksi lähde.')
        return redirect('/')
    
    for item in selected:
        try:
            typ, item_id = item.split(':')
        except ValueError:
            continue
        if typ == 'book':
            db.session.execute(text('DELETE FROM books WHERE id = :id'), {'id': item_id})
        elif typ == 'article':
            db.session.execute(text('DELETE FROM articles WHERE id = :id'), {'id': item_id})
    
    db.session.commit()
    return redirect('/')

@app.route('/download_selected', methods=['POST'])
def download_selected():
    selected = request.form.getlist('selected')

    if not selected:
        flash('Valitse vähintään yksi lähde.')
        return redirect('/')
    
    bibtex_entries = []
    
    for item in selected:
        try:
            typ, item_id = item.split(':')
        except ValueError:
            continue
        
        if typ == 'book':
            sql = text('SELECT * FROM books WHERE id = :id')
            query = db.session.execute(sql, {'id': item_id})
            book = query.fetchone()
            if book:
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
        
        elif typ == 'article':
            sql = text('SELECT * FROM articles WHERE id = :id')
            query = db.session.execute(sql, {'id': item_id})
            article = query.fetchone()
            if article:
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

@app.route('/miniprojekti_siella_ohtussa', methods=['GET', 'POST'])
def projekti():
    return render_template("miniprojekti_siella_ohtussa.html")
    
