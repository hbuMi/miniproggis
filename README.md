# miniproggis
Backlogit:
https://docs.google.com/spreadsheets/d/1gUeDFhVrELOU87sLws3sC4URveYEWVas-GuFzPqPSQs/edit?gid=1#gid=1

## Definition of done:
- The feature meets the agreed requirements and functions as expected
- Code is structured clearly
- The feature includes sufficient automated test coverage

## Asennus

**Kloonaa repositorio**

```
git clone git@github.com:hbuMi/miniproggis.git
```

**Siirry repositorioon**

```
cd miniproggis
```

**Asenna riippuvuudet**

```
poetry install
```

**Siirry virtuaaliympäristöön**

```
eval $(poetry env activate)
```

**Luo .env tiedosto ja lisää secrets**

```
touch .env
```

**Käynnistä sovellus**

```
python3 src/index.py
```