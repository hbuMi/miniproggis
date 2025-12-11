from sqlalchemy import text
from config import db


def create_book(name, author, title, year, editor, publisher, note):
    sql = text("INSERT INTO books (name, title, author, year, editor, publisher, note) VALUES (:name, :title, :author, :year, :editor, :publisher, :note)")
    db.session.execute(sql, {"name": name,
                             "title": title,
                             "author": author,
                             "year": year,
                             "editor": editor,
                             "publisher": publisher,
                             "note": note })
    db.session.commit()

def create_article(name, author, title, year, journal, note):
    sql = text("INSERT INTO articles (name, author, title, year, journal, note) VALUES (:name, :author, :title, :year, :journal, :note)")
    db.session.execute(sql, {"name": name,
                             "title": title,
                             "author": author,
                             "journal": journal,
                             "year": year,
                             "note": note })
    db.session.commit()

def update_book(reference_id, name, author, title, year, editor, publisher, note):
    sql = text("SELECT 1 FROM books WHERE id = :id")
    result = db.session.execute(sql, {"id": reference_id})
    if result.fetchone() is None:
        raise Exception("Book reference with the given ID does not exist.")
    
    sql = text("UPDATE books SET name = :name, author = :author, title = :title, year = :year, editor = :editor, publisher = :publisher, note = :note WHERE id = :id")
    db.session.execute(sql, {"id": reference_id,
                             "name": name,
                             "author": author,
                             "title": title,
                             "year": year,
                             "editor": editor,
                             "publisher": publisher,
                             "note": note })
    db.session.commit()

def update_article(reference_id, name, author, title, year, journal, note):
    sql = text("SELECT 1 FROM articles WHERE id = :id")
    result = db.session.execute(sql, {"id": reference_id})
    if result.fetchone() is None:
        raise Exception("Article reference with the given ID does not exist.")
    
    sql = text("UPDATE articles SET name = :name, author = :author, title = :title, year = :year, journal = :journal, note = :note WHERE id = :id")
    db.session.execute(sql, {"id": reference_id,
                             "name": name,
                             "author": author,
                             "title": title,
                             "year": year,
                             "journal": journal,
                             "note": note })
    db.session.commit()

def get_all_books():
    sql = text("SELECT *, 'book' as type FROM books")
    result = db.session.execute(sql)
    return result.fetchall()

def get_all_articles():
    sql = text("SELECT *, 'article' as type FROM articles")
    result = db.session.execute(sql)
    return result.fetchall()

def get_reference(ref_type, id):
    if ref_type == 'book':
        sql = text('SELECT * FROM books WHERE id = :id')
    elif ref_type == 'article':
        sql = text('SELECT * FROM articles WHERE id = :id')

    query = db.session.execute(sql, {'id': id})
    return query.fetchone()

def delete_references():
    db.session.execute(text("DELETE FROM books"))
    db.session.execute(text("DELETE FROM articles"))
    db.session.commit()

def search_references(query, mindate, maxdate, author):
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
        result = db.session.execute(sql, {"query": f"%{query}%", "mindate": mindate, "maxdate": maxdate, "author": f"%{author}%"})
        return result.fetchall()

def delete_reference(ref_type, id):
    if ref_type == 'book':
        db.session.execute(text('DELETE FROM books WHERE id = :id'), {'id': id})
    elif ref_type == 'article':
        db.session.execute(text('DELETE FROM articles WHERE id = :id'), {'id': id})
    db.session.commit()
