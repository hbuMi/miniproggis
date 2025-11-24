from config import db
from sqlalchemy import text

def create_book(name, author, title, year, editor, publisher, note):
    sql = text("INSERT INTO sources (name, title, author, year, publisher, note) VALUES (:name, :title, :author, :year, :publisher, :note)")
    db.session.execute(sql, {"name": name,
                             "title": title,
                             "author": author,
                             "year": year,
                             "publisher": publisher,
                             "note": note })
    db.session.commit()

def print_all_titles():
    result = db.session.execute(text("SELECT title FROM sources"))
    titles = result.fetchall()
    for row in titles:
        print(row.title)