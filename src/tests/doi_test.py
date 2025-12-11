import unittest
from unittest.mock import patch
from doi import get_bibtex_from_doi


class TestDOIFunctions(unittest.TestCase):
    def setUp(self):
        pass

    def test_get_bibtex_from_doi_success(self):
        doi = "10.1000/testdoi"
        expected_bibtex = "@article{example, title={An example article}}"

        with patch("requests.get") as mock_get:
            mock_get.return_value.text = expected_bibtex

            result = get_bibtex_from_doi(doi)
            assert result == expected_bibtex
            mock_get.assert_called_once_with(
                f"http://dx.doi.org/{doi}",
                headers={"accept": "application/x-bibtex"}
            )
