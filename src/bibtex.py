import bibtexparser
from bibtexparser.bparser import BibTexParser
from bibtexparser.customization import convert_to_unicode
from util import UserInputError

def parse_bibtex(bibtex_data):
    parser = BibTexParser()
    parser.customization = convert_to_unicode

    parsed_data = bibtexparser.loads(bibtex_data, parser)
    try:
        data_dict = parsed_data.entries[0]
    except IndexError:
        raise UserInputError("Virheellinen tai väärän lähdetyypin DOI")
    ref_type = data_dict["ENTRYTYPE"].lower()
    if ref_type != "article" and ref_type != "book":
        raise UserInputError("Virheellinen tai väärän lähdetyypin DOI")
    return data_dict
