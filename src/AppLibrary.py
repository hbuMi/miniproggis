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
            'publisher': publisher,
            'note': note
        }
        requests.post(f"{self._base_url}/create_book", data=data)

    def reset_database(self):
        requests.get(f"{self._base_url}/reset_db")