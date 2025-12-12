import unittest
from util import validate_article, UserInputError


class TestArticleValidation(unittest.TestCase):
    def setUp(self):
        pass

    def test_valid_author_does_not_raise_error(self):
        try:
            validate_article("Author Name", "Title", "Journal Name", "2025", "A note")
        except UserInputError:
            self.fail("validate_article raised UserInputError unexpectedly!")

    def test_author_too_short_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_article("Au", "Title", "Journal Name", "2025", "A note")

    def test_author_with_number_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_article("Author1", "Title", "Journal Name", "2025", "A note")

    def test_valid_year_does_not_raise_error(self):
        try:
            validate_article("Author Name", "Title", "Journal Name", "2025", "A note")
        except UserInputError:
            self.fail("validate_article raised UserInputError unexpectedly!") 
    
    def test_year_not_a_number_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_article("Author Name", "Title", "Journal Name", "Year", "A note")

    def test_negative_year_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_article("Author Name", "Title", "Journal Name", "-2025", "A note")

    def test_future_year_raises_error(self):
        import datetime
        future_year = str(datetime.datetime.now().year + 1)
        with self.assertRaises(UserInputError):
            validate_article("Author Name", "Title", "Journal Name", future_year, "A note")

    def test_valid_journal_does_not_raise_error(self):
        try:
            validate_article("Author Name", "Title", "Journal Name", "2025", "A note")
        except UserInputError:
            self.fail("validate_article raised UserInputError unexpectedly!")

    def test_journal_too_short_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_article("Author Name", "Title", "Jo", "2025", "A note")

    def test_journal_with_number_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_article("Author Name", "Title", "Journal1", "2025", "A note")
    
    def test_valid_note_does_not_raise_error(self):
        try:
            validate_article("Author Name", "Title", "Journal Name", "2025", "A note")
        except UserInputError:
            self.fail("validate_article raised UserInputError unexpectedly!")

    def test_note_too_long_raises_error(self):
        long_note = "a" * 301
        with self.assertRaises(UserInputError):
            validate_article("Author Name", "Title", "Journal Name", "2025", long_note)

    def test_valid_title_does_not_raise_error(self):
        try:
            validate_article("Author Name", "Title", "Journal Name", "2025", "A note")
        except UserInputError:
            self.fail("validate_article raised UserInputError unexpectedly!")

    def test_title_too_short_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_article("Author Name", "Ti", "Journal Name", "2025", "A note")
