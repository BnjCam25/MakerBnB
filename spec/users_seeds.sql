TRUNCATE TABLE users RESTART IDENTITY CASCADE;

INSERT INTO users(name, email, password) VALUES('Bob Dylan', 'bd@gmail.com', '12345678');
INSERT INTO users(name, email, password) VALUES('Dylan Bob', 'db@gmail.com', '98345678');
INSERT INTO users(name, email, password) VALUES('Dob Bylan', 'b_d@gmail.com', '32145678');



TRUNCATE TABLE properties RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO properties (name, description, price) VALUES ('Sandsend', 'Stunning appartment with a view of the sea front', 200);
INSERT INTO properties (name, description, price) VALUES ('Quaint Cottage', 'Sleepy little cottage with an apple orchard', 150);

TRUNCATE TABLE dates RESTART IDENTITY CASCADE; 

INSERT INTO dates (start_date, end_date) VALUES ('2022/06/05','2022/06/15');
INSERT INTO dates (start_date, end_date) VALUES ('2022/06/20','2022/06/25');
INSERT INTO dates (start_date, end_date) VALUES ('2022/04/20','2022/04/25');


TRUNCATE TABLE property_dates RESTART IDENTITY CASCADE;
INSERT INTO property_dates (property_id, date_id) VALUES ('1','1');
INSERT INTO property_dates (property_id, date_id) VALUES ('1','2');
INSERT INTO property_dates (property_id, date_id) VALUES ('2','2');
INSERT INTO property_dates (property_id, date_id) VALUES ('2','3');


