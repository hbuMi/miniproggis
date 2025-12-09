import requests

def get_bibtex_from_doi(doi):
    url = f"http://dx.doi.org/{doi}"
    headers = {"accept": "application/x-bibtex"}
    try:
        req = requests.get(url, headers=headers)
        return req.text
    except requests.exceptions.RequestException as error:
        return f"Error: {error}"
