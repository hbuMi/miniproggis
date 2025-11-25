#pylint: disable=invalid-name
import requests

class AppLibrary:
    def __init__(self):
        self._base_url = "http://localhost:5001"

    def create_book(self, name, author, title, year, editor, publisher, note):
        data = {
            'name': name,
            'author': author,
            'title': title,
            'year': year,
            'editor': editor,
            'publisher': publisher,
            'note': note
        }
        requests.post(f"{self._base_url}/create_book", data=data, timeout=10)

    def create_article(self, name, author, title, year, journal, note):
        data = {
            'name': name,
            'author': author,
            'title': title,
            'year': year,
            'journal': journal,
            'note': note
        }
        requests.post(f"{self._base_url}/create_article", data=data, timeout=10)

    def reset_database(self):
        requests.get(f"{self._base_url}/reset_db", timeout=10)
