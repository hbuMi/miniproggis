#pylint: disable=invalid-name,unused-argument,missing-function-docstring
import threading
from unittest.mock import patch, MagicMock
import requests
from app import app

class AppLibrary:
    def __init__(self):
        self._base_url = "http://localhost:5001"
        self._app_thread = None
        self._mock_get = None
        self._patcher = None

    def start_mock_application(self):
        self._base_url = "http://localhost:5002"

        self._patcher = patch("requests.get")
        self._mock_get = self._patcher.start()

        def side_effect(url, *args, **kwargs):
            if "10.1000/valid_doi" in url:
                mock_response = MagicMock()
                mock_response.text = """@article{test_cite, 
                    title={Test Article},
                    author={Tester, Alpha},
                    year={2024},
                    journal={Journal of Testing}
                }"""
                mock_response.status_code = 200
            else:
                mock_response = MagicMock()
                mock_response.text = "DOI not found"
                mock_response.status_code = 404

            return mock_response

        self._mock_get.side_effect = side_effect

        def run_app():
            app.run(port=5002, use_reloader=False)

        self._app_thread = threading.Thread(target=run_app, daemon=True)
        self._app_thread.start()

        import time
        time.sleep(1)

    def stop_mock_application(self):
        if self._patcher:
            self._patcher.stop()
        self._base_url = "http://localhost:5001"

    def create_book(self, name, author, title, year, editor, publisher, note):
        data = {
            "name": name,
            "author": author,
            "title": title,
            "year": year,
            "editor": editor,
            "publisher": publisher,
            "note": note
        }
        requests.post(f"{self._base_url}/create_book", data=data, timeout=10)

    def create_article(self, name, author, title, year, journal, note):
        data = {
            "name": name,
            "author": author,
            "title": title,
            "year": year,
            "journal": journal,
            "note": note
        }
        requests.post(f"{self._base_url}/create_article", data=data, timeout=10)

    def reset_database(self):
        requests.get(f"{self._base_url}/reset_db", timeout=10)
