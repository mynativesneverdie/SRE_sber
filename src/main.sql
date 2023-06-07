CREATE SCHEMA main;

CREATE TABLE main.station (
	id           SERIAL PRIMARY KEY,
	name_station VARCHAR(255) NOT NULL,
	city         VARCHAR(255) NOT NULL,
	region       VARCHAR(255) NOT NULL
);


CREATE TABLE main.train (
	id             SERIAL PRIMARY KEY,
	name_train     VARCHAR(255) NOT NULL,
	type_train     VARCHAR(255) NOT NULL,
	capacity_train INT
);

CREATE TABLE main.route (
	id                SERIAL PRIMARY KEY,
	id_start_station  INT NOT NULL,
	id_finish_station INT NOT NULL,
	lenght            DECIMAL,
	constraint fk_route_start_id foreign key (id_start_station) references station (id),
	constraint fk_route_finish_id foreign key (id_finish_station) references station (id)
);

CREATE TABLE main.schedule (
    id SERIAL PRIMARY KEY,
    id_train INT NOT NULL,
    id_route INT NOT NULL
);

CREATE TYPE main.check_ticket_status AS ENUM ('sold', 'free');

INSERT INTO main.station (id, name_station, city, region)
VALUES (1, 'Bot_Sad', 'Moscow', 'CFO'),
       (2, 'Kazan-2', 'Kazan', 'PFO'),
       (3, 'Snt.P', 'Saint Peterburg', 'SZFO');
	
INSERT INTO main.train (id, name_train, type_train, capacity_train)
VALUES (1, 'M01', 'standart train', 650),
       (2, 'M02', 'express train', 550),
	   (3, 'K01', 'standart train', 650),
       (4, 'K02', 'express train', 550),
	   (5, 'SP01', 'standart train', 650),
       (6, 'SP02', 'express train', 550);
	      
INSERT INTO main.route (id, id_start_station, id_finish_station, lenght)
VALUES (1, 1, 2, 800.5),
       (2, 1, 3, 750.6),
	   (3, 2, 1, 800.5),
	   (4, 2, 3, 1500.2),
	   (5, 3, 2, 1500.2),
	   (6, 3, 1, 750.6);

CREATE INDEX IF NOT EXISTS idx_schedule_id_train ON schedule USING btree (id_train);
CREATE INDEX IF NOT EXISTS idx_person_order_person_id ON person_order USING btree (person_id);
CREATE INDEX IF NOT EXISTS idx_person_order_menu_id ON person_order USING btree (menu_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_person_id ON person_visits USING btree (person_id);
CREATE INDEX IF NOT EXISTS idx_person_visits_pizzeria_id ON person_visits USING btree (pizzeria_id);