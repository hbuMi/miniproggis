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

def print_all_titles():
    result = db.session.execute(text("SELECT title FROM books"))
    titles = result.fetchall()
    for row in titles:
        print(row.title)
