from types import SimpleNamespace
import unittest
from util import create_bibtex, validate_doi_fields


class TestUtilFunctions(unittest.TestCase):
    def setUp(self):
        pass

    def test_create_bibtex_book(self):
        book = SimpleNamespace(
            name="clean_code",
            author="Robert C. Martin",
            title="Clean Code: A Handbook of Agile Software Craftsmanship",
            year="2008",
            editor="Some Editor",
            publisher="Prentice Hall",
            note="Must read for developers"
        )

        expected_bibtex = (
            "@book{clean_code,\n"
            "  title      = \"Clean Code: A Handbook of Agile Software Craftsmanship\",\n"
            "  author     = \"Robert C. Martin\",\n"
            "  year       = \"2008\",\n"
            "  editor     = \"Some Editor\",\n"
            "  publisher  = \"Prentice Hall\",\n"
            "  note       = \"Must read for developers\"\n"
            "}"
        )

        actual_bibtex = create_bibtex(book, ref_type="book")
        self.assertEqual(expected_bibtex, actual_bibtex)

    def test_create_bibtex_book_without_optional_fields(self):
        book = SimpleNamespace(
            name="the_pragmatic_programmer",
            author="Andrew Hunt, David Thomas",
            title="The Pragmatic Programmer: Your Journey to Mastery",
            year="1999",
            editor="",
            publisher="",
            note=""
        )

        expected_bibtex = (
            "@book{the_pragmatic_programmer,\n"
            "  title      = \"The Pragmatic Programmer: Your Journey to Mastery\",\n"
            "  author     = \"Andrew Hunt, David Thomas\",\n"
            "  year       = \"1999\"\n"
            "}"
        )

        actual_bibtex = create_bibtex(book, ref_type="book")
        self.assertEqual(expected_bibtex, actual_bibtex)

    def test_create_bibtex_article(self):
        article = SimpleNamespace(
            name="attention2017",
            author="Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin",
            title="Attention Is All You Need",
            year="2017",
            journal="Advances in Neural Information Processing Systems",
            note="Test article"
        )

        expected_bibtex = (
            "@article{attention2017,\n"
            "  title      = \"Attention Is All You Need\",\n"
            "  author     = \"Ashish Vaswani, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N. Gomez, Łukasz Kaiser, Illia Polosukhin\",\n"
            "  year       = \"2017\",\n"
            "  journal    = \"Advances in Neural Information Processing Systems\",\n"
            "  note       = \"Test article\"\n"
            "}"
        )

        actual_bibtex = create_bibtex(article, ref_type="article")
        self.assertEqual(expected_bibtex, actual_bibtex)

    def test_create_bibtex_article_without_optional_fields(self):
        article = SimpleNamespace(
            name="deep_learning2015",
            author="Yann LeCun, Yoshua Bengio, Geoffrey Hinton",
            title="Deep Learning",
            year="2015",
            journal="Nature",
            note=""
        )

        expected_bibtex = (
            "@article{deep_learning2015,\n"
            "  title      = \"Deep Learning\",\n"
            "  author     = \"Yann LeCun, Yoshua Bengio, Geoffrey Hinton\",\n"
            "  year       = \"2015\",\n"
            "  journal    = \"Nature\"\n"
            "}"
        )

        actual_bibtex = create_bibtex(article, ref_type="article")
        self.assertEqual(expected_bibtex, actual_bibtex)

    def test_validate_doi_fields_returns_all(self):
        data = {
            "ENTRYTYPE": "article",
            "author": "Alpha Tester",
            "title": "Sample Title",
            "year": "2020",
            "journal": "Journal of Testing"
        }
        fields = ["author", "title", "year", "journal"]

        validated_data = validate_doi_fields(data, fields)

        self.assertEqual(validated_data["author"], "Alpha Tester")
        self.assertEqual(validated_data["title"], "Sample Title")
        self.assertEqual(validated_data["year"], "2020")
        self.assertEqual(validated_data["journal"], "Journal of Testing")

    def test_validate_doi_fields_missing_replaced_empty_strings(self):
        data = {
            "ENTRYTYPE": "article",
            "author": "Alpha Tester",
            "title": "Sample Title"
        }
        fields = ["author", "title", "year", "journal"]

        validated_data = validate_doi_fields(data, fields)

        self.assertEqual(validated_data["author"], "Alpha Tester")
        self.assertEqual(validated_data["title"], "Sample Title")
        self.assertEqual(validated_data["year"], "")
        self.assertEqual(validated_data["journal"], "")
