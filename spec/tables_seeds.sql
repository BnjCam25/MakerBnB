
DROP TABLE IF EXISTS users CASCADE;


CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  password text

);

DROP TABLE IF EXISTS properties CASCADE;

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price numeric,

	user_id int, 
  	constraint fk_user foreign key(user_id)
  	references users(id)
  	on delete cascade
  	);


DROP TABLE IF EXISTS property_dates CASCADE;

CREATE TABLE property_dates (
  id SERIAL PRIMARY KEY,
  property_id int,
  date_id int
);

DROP TABLE IF EXISTS dates CASCADE;


CREATE TABLE dates (
  id SERIAL PRIMARY KEY,
  start_date date,
  end_date date
);
