TRUNCATE TABLE properties RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO properties (name, description, price, user_id) VALUES ('Sandsend', 'Stunning appartment with a view of the sea front', 200, 1);
INSERT INTO properties (name, description, price, user_id) VALUES ('Quaint Cottage', 'Sleepy little cottage with an apple orchard', 150, 2);