DROP TABLE IF EXISTS properties;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  password text

);

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



