import datetime
import re

class UserInputError(Exception):
    pass

def validate_book(author, title, year, editor, publisher, note):
    _validate_author(author)
    _validate_title(title)
    _validate_year(year)
    _validate_editor(editor)
    _validate_publisher(publisher)
    _validate_note(note)

def validate_article(author, title, journal, year):
    _validate_author(author)
    _validate_title(title)
    _validate_publisher(journal)
    _validate_year(year)

def _validate_year(year):
    # Testi onko vuosi luku
    try:
        year = int(year)
    except ValueError:
        raise UserInputError("Vuoden oltava luku")

    # Testi onko vuosi positiivinen luku
    if year < 0:
        raise UserInputError("Vuosi ei voi olla negatiivinen")

    # Testi onko vuosi enintään nykyinen
    date = datetime.datetime.now()
    if year > date.year:
        raise UserInputError("Ei tulevaisuuden kirjoja")

def _validate_author(author):
    # Testi onko author ainakin 3 merkkiä pitkä
    if len(author) < 3:
        raise UserInputError("Liian lyhyt kirjoittaja")

    # Testi ettei nimessä numeroita
    if (bool(re.search(r'/d', author))) is True:
        raise UserInputError("Kirjoittajan nimessä ei kuulu olla numeroita")

def _validate_editor(editor):
    # Testi onko editor ainakin 3 merkkiä pitkä, jos kentässä jotain
    if len(editor) > 0 and len(editor) < 3:
        raise UserInputError("Liian lyhyt muokkaaja")

    # Testi ettei nimessä numeroita
    if (bool(re.search(r'/d', editor))) is True:
        raise UserInputError("Muokkaajan nimessä ei kuulu olla numeroita")

def _validate_publisher(publisher):
    # Testi onko julkaisija ainakin 3 merkkiä pitkä
    if len(publisher) < 3:
        raise UserInputError("Liian lyhyt julkaisija")

    # Testi ettei nimessä numeroita
    if (bool(re.search(r'/d', publisher))) is True:
        raise UserInputError("Julkaisijan nimessä ei kuulu olla numeroita")

def _validate_title(title):
    # Testi onko nimi ainakin 3 merkkiä pitkä
    if len(title) < 3:
        raise UserInputError("Liian lyhyt nimi")

def _validate_note(note):
    # Testi onko note enintään 300 merkkiä
    if len(note) > 300:
        raise UserInputError("Note enimmäispituus 300 merkkiä")
