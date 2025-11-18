class UserInputError(Exception):
    pass

def validate_book(author, title, year):
    try:
        int(year)
    except ValueError:
        raise UserInputError("Vuoden oltava luku")
