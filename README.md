# miniproggis

### Miniprojektin loppuraportti
[loppuraportti](/raportti.pdf)

### Backlogit:
https://docs.google.com/spreadsheets/d/1gUeDFhVrELOU87sLws3sC4URveYEWVas-GuFzPqPSQs/edit?gid=1#gid=1

### Testikattavuus
https://app.codecov.io/github/hbumi/miniproggis

## Definition of done:
- The feature meets the agreed requirements and functions as expected
- Code is structured clearly
- The feature includes sufficient automated test coverage

## Asennus

**Kloonaa repositorio**

```
git clone git@github.com:hbuMi/miniproggis.git
```

**Asenna riippuvuudet**

```
cd miniproggis
poetry install
```

**Siirry virtuaaliympäristöön**

```
eval $(poetry env activate)
```

**Postgres**

Varmista, että postgres -palvelin on käynnissä ja sen jälkeen luo ja alusta uusi tietokanta.

```
psql
user=# CREATE DATABASE <uuden-tietokannan-nimi>;
user=# \q
psql -d <uuden-tietokannan-nimi> < src/schema.sql
```

**Luo .env -tiedosto**

```
touch .env
```
**Lisää .env -tiedostoon salaisuudet**
```
TEST_ENV=true
DATABASE_URL=postgresql:///<uuden-tietokannan-nimi>
SECRET_KEY=<aseta-salainen-avain>
```

**Käynnistä sovellus**

```
python3 src/index.py
```