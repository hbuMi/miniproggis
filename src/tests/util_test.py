from types import SimpleNamespace
import unittest
from util import create_bibtex


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