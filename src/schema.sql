CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  name TEXT, 
  title TEXT,
  author TEXT,
  year TEXT,
  editor TEXT,
  publisher TEXT,
  note TEXT
);

CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  author TEXT,
  title TEXT,
  journal TEXT,
  year TEXT,
  note TEXT
);
