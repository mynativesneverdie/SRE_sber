CREATE TABLE train (
    id             SERIAL PRIMARY KEY,
    name_train     VARCHAR NOT NULL,
    type_train     VARCHAR NOT NULL,
    capacity_train INT
);

CREATE TABLE station (
    id           SERIAL PRIMARY KEY,
    name_station VARCHAR NOT NULL,
    city         VARCHAR NOT NULL,
    region       VARCHAR NOT NULL
);

CREATE TABLE route (
    id                 SERIAL PRIMARY KEY,
    id_start_station   INT REFERENCES station(id),
    id_finish_station  INT REFERENCES station(id),
    length             DECIMAL
);

CREATE TABLE schedule (
    id          SERIAL PRIMARY KEY,
    id_train    INT REFERENCES train(id),
    id_route    INT REFERENCES route(id),
    date_start  DATE NOT NULL,
    time_start  TIME NOT NULL,
    date_finish DATE NOT NULL,
    time_finish TIME NOT NULL
);

CREATE TYPE check_ticket_status AS ENUM ('sold', 'free');

CREATE TABLE ticket (
    id          BIGSERIAL PRIMARY KEY,
    id_schedule INT REFERENCES schedule(id),
    price       DECIMAL NOT NULL,
    status      check_ticket_status,
    buy_time    TIMESTAMP DEFAULT NULL,
    refund_time TIMESTAMP DEFAULT NULL
);

INSERT INTO train (name_train, type_train, capacity_train)
VALUES ('M01', 'standart train', 650),
       ('M02', 'express train', 550),
	   ('K01', 'standart train', 650),
       ('K02', 'express train', 550);

INSERT INTO station (name_station, city, region)
VALUES ('3-Vokzala', 'Moscow', 'CFO'),
       ('Kazan-2', 'Kazan', 'PFO');
    
INSERT INTO route (id_start_station, id_finish_station, length)
VALUES (1, 2, 800.5),
	   (2, 1, 800.5);

INSERT INTO schedule (id_train, id_route, date_start, time_start, date_finish, time_finish)
VALUES (1, 1, '2023-06-07', '13:00:00', '2023-06-08', '05:00:00'),
       (2, 1, '2023-06-07', '15:00:00', '2023-06-07', '23:00:00'),
       (3, 2, '2023-06-08', '07:00:00', '2023-06-08', '21:00:00'),
       (4, 2, '2023-06-08', '10:00:00', '2023-06-08', '18:00:00');

INSERT INTO ticket (id_schedule, price, status, buy_time)
VALUES (1, 1500, 'free', null),
       (1, 1500, 'free', null),
       (1, 1500, 'sold', '2023-06-06 21:00:00'),
       (3, 1500, 'free', null),
       (3, 1500, 'free', null),
       (3, 1500, 'sold', '2023-06-08 06:59:00');

CREATE INDEX IF NOT EXISTS idx_schedule_id_train ON schedule USING btree (id_train);
CREATE INDEX IF NOT EXISTS idx_schedule_id_route ON schedule USING btree (id_route);
CREATE INDEX IF NOT EXISTS idx_route_id_start ON route USING btree (id_start_station);
CREATE INDEX IF NOT EXISTS idx_route_id_finish ON route USING btree (id_finish_station);
CREATE INDEX IF NOT EXISTS idx_ticket_id_schedule ON ticket USING btree (id_schedule);