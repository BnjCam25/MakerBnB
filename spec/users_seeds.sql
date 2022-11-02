TRUNCATE TABLE users RESTART IDENTITY CASCADE;

INSERT INTO users(name, email, password) VALUES('Bob Dylan', 'bd@gmail.com', '12345678');
INSERT INTO users(name, email, password) VALUES('Dylan Bob', 'db@gmail.com', '98345678');
INSERT INTO users(name, email, password) VALUES('Dob Bylan', 'b_d@gmail.com', '32145678');