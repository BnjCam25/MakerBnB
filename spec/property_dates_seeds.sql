DROP TABLE property_dates;

CREATE TABLE property_dates (
  id SERIAL PRIMARY KEY,
  property_id int,
  date_id int
);

CREATE TABLE dates (
  id SERIAL PRIMARY KEY,
  date date
);
