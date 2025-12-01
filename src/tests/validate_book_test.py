import unittest
from util import validate_book, UserInputError
import datetime


class TestBookValidation(unittest.TestCase):
    def setUp(self):
        pass

    def test_valid_author_does_not_raise_error(self):
        try:
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher Name", "A note")
        except UserInputError:
            self.fail("validate_book raised UserInputError unexpectedly!")

    def test_author_too_short_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Au", "Title", "2025", "Editor Name", "Publisher Name", "A note")

    def test_author_with_number_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author1", "Title", "2025", "Editor Name", "Publisher Name", "A note")

    def test_valid_year_does_not_raise_error(self):
        try:
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher Name", "A ote")
        except UserInputError:
            self.fail("validate_book raised UserInputError unexpectedly!")

    def test_year_not_a_number_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", "Year", "Editor Name", "Publisher Name", "A note")

    def test_negative_year_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", "-2025", "Editor Name", "Publisher Name", "A note")

    def test_future_year_raises_error(self):
        future_year = str(datetime.datetime.now().year + 1)
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", future_year, "Editor Name", "Publisher Name", "A note")

    def test_valid_editor_does_not_raise_error(self):
        try:
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher Name", "A note")
        except UserInputError:
            self.fail("validate_book raised UserInputError unexpectedly!")

    def test_editor_too_short_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", "2025", "Ed", "Publisher Name", "A note")

    def test_editor_with_number_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", "2025", "Editor1", "Publisher Name", "A note")

    def test_valid_publisher_does_not_raise_error(self):
        try:
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher Name", "A note")
        except UserInputError:
            self.fail("validate_book raised UserInputError unexpectedly!")

    def test_publisher_too_short_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", "2025", "Editor Name", "Pu", "A note")
    
    def test_publisher_with_number_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher1", "A note")

    def test_valid_title_does_not_raise_error(self):
        try:
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher Name", "A note")
        except UserInputError:
            self.fail("validate_book raised UserInputError unexpectedly!")

    def test_title_too_short_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Ti", "2025", "Editor Name", "Publisher Name", "A note")

    def test_valid_note_does_not_raise_error(self):
        try:
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher Name", "A note")
        except UserInputError:
            self.fail("validate_book raised UserInputError unexpectedly!")

    def test_note_too_long_raises_error(self):
        note = "a" * 301
        with self.assertRaises(UserInputError):
            validate_book("Author Name", "Title", "2025", "Editor Name", "Publisher Name", note)
