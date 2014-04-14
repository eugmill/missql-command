CREATE TABLE cities (id serial PRIMARY KEY, name VARCHAR(255), population INTEGER);

INSERT INTO cities (name,population) VALUES ('New York', 9000000);
INSERT INTO cities (name,population) VALUES ('Paris', 8000000);
INSERT INTO cities (name,population) VALUES ('San Francisco', 825000);
INSERT INTO cities (name,population) VALUES ('Moscow', 11000000);
INSERT INTO cities (name,population) VALUES ('Tokyo', 13000000);

CREATE TABLE missiles (id serial PRIMARY KEY,name VARCHAR(255), megatons INTEGER);

INSERT INTO missiles (name, megatons) VALUES ('Big Boy', 34000000);
INSERT INTO missiles (name, megatons) VALUES ('Fat Man', 54500000);
INSERT INTO missiles (name, megatons) VALUES ('Smiling Buddha', 213450);
INSERT INTO missiles (name, megatons) VALUES ('Tsar Bomba', 1134000);
INSERT INTO missiles (name, megatons) VALUES ('Trinity', 11400);
INSERT INTO missiles (name, megatons) VALUES ('bBig Boy', 34000000);
INSERT INTO missiles (name, megatons) VALUES ('bFat Man', 54500000);
INSERT INTO missiles (name, megatons) VALUES ('bSmiling Buddha', 213450);
INSERT INTO missiles (name, megatons) VALUES ('bTsar Bomba', 1134000);
INSERT INTO missiles (name, megatons) VALUES ('bTrinity', 11400);
INSERT INTO missiles (name, megatons) VALUES ('cBig Boy', 34000000);
INSERT INTO missiles (name, megatons) VALUES ('cFat Man', 54500000);
INSERT INTO missiles (name, megatons) VALUES ('cSmiling Buddha', 213450);
INSERT INTO missiles (name, megatons) VALUES ('cTsar Bomba', 1134000);
INSERT INTO missiles (name, megatons) VALUES ('cTrinity', 11400);
