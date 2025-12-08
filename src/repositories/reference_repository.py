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

def print_all_titles():
    result = db.session.execute(text("SELECT title FROM articles"))
    titles = result.fetchall()
    for row in titles:
        print(row.title)

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
