import unittest
from unittest.mock import patch

import requests
from doi import get_bibtex_from_doi
from bibtex import parse_bibtex


class TestDOIFunctions(unittest.TestCase):
    def setUp(self):
        pass

    def test_get_bibtex_from_doi_success(self):
        doi = "10.1000/testdoi"
        expected_bibtex = "@article{example, title={An example article}}"

        with patch("requests.get") as mock_get:
            mock_get.return_value.text = expected_bibtex

            result = get_bibtex_from_doi(doi)
            self.assertEqual(result, expected_bibtex)
            mock_get.assert_called_once_with(
                f"http://dx.doi.org/{doi}",
                headers={"accept": "application/x-bibtex"}
            )
    
    def test_get_bibtex_from_doi_failure(self):
        doi = "10.1000/invaliddoi"

        with patch("requests.get") as mock_get:
            mock_get.side_effect = requests.exceptions.RequestException("Connection error")

            result = get_bibtex_from_doi(doi)
            self.assertIn("Error: Connection error", result)
            mock_get.assert_called_once_with(
                f"http://dx.doi.org/{doi}",
                headers={"accept": "application/x-bibtex"}
            )

    def test_parse_bibtex_with_valid_input(self):
        bibtex_str = (
            "@article{example,\n"
            "  title={An example article},\n"
            "  author={Tester, Alpha},\n"
            "  year={2020},\n"
            "  journal={Journal of Examples}\n"
            "}"
        )

        expected_entry = {
            "ENTRYTYPE": "article",
            "title": "An example article",
            "author": "Tester, Alpha",
            "year": "2020",
            "journal": "Journal of Examples"
        }

        result = parse_bibtex(bibtex_str)
        for key in expected_entry:
            self.assertEqual(result[key], expected_entry[key])

    def test_parse_bibtex_with_invalid_type(self):
        bibtex_str = (
            "@misc{example,\n"
            "  title={An example misc},\n"
            "  author={Tester, Alpha},\n"
            "  year={2020}\n"
            "}"
        )

        with self.assertRaises(Exception) as context:
            parse_bibtex(bibtex_str)
        self.assertIn("Virheellinen tai väärän lähdetyypin DOI", str(context.exception))

    def test_parse_bibtex_with_empty_input(self):
        bibtex_str = ""

        with self.assertRaises(Exception) as context:
            parse_bibtex(bibtex_str)
        self.assertIn("Virheellinen tai väärän lähdetyypin DOI", str(context.exception))

    def test_parse_bibtex_with_invalid_doi(self):
        bibtex_str = "This is not a valid bibtex entry."

        with self.assertRaises(Exception) as context:
            parse_bibtex(bibtex_str)
        self.assertIn("Virheellinen tai väärän lähdetyypin DOI", str(context.exception))
