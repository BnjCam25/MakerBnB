CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price numeric
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  password text
);