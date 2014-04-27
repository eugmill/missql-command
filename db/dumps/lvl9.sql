CREATE TABLE cities (city_id serial PRIMARY KEY, city_name VARCHAR(255), population INTEGER);

INSERT INTO cities (city_name,population) VALUES ('New York', 8337000);
INSERT INTO cities (city_name,population) VALUES ('Paris', 2211000);
INSERT INTO cities (city_name,population) VALUES ('San Francisco', 825000);
INSERT INTO cities (city_name,population) VALUES ('London', 8308000);
INSERT INTO cities (city_name,population) VALUES ('Moscow', 11500000);
INSERT INTO cities (city_name,population) VALUES ('Tokyo', 13230000);
INSERT INTO cities (city_name,population) VALUES ('Shanghai', 24000000);

CREATE TABLE missiles (missile_id serial PRIMARY KEY, model_name VARCHAR(255), nationality VARCHAR(255), target_city_id INTEGER);

INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Peacekeeper','USA', 7);
INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Minuteman','USA', 5);
INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Topol','Russia', 1);
INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Yars','Russia', 4);
INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Jericho III','Israel', 5);
INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Agni-V','India', 7);
INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Dongfeng-5','China', 3);
INSERT INTO missiles (model_name, nationality, target_city_id) VALUES ('Dongfeng-31','China', 6);