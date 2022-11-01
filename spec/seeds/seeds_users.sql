TRUNCATE TABLE users RESTART IDENTITY; 

INSERT INTO users (email, password) VALUES ('qwerty@abc.com', 'asdfgh123');
INSERT INTO users (email, password) VALUES ('asdfgh@abc.com', 'qwerty123');