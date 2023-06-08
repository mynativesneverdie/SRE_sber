CREATE SCHEMA security;

CREATE TABLE security.roles (
  role_id   SERIAL PRIMARY KEY,
  role_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE security.users (
  user_id  SERIAL PRIMARY KEY,
  username VARCHAR UNIQUE NOT NULL,
  password VARCHAR NOT NULL,
  role_id  INT REFERENCES security.roles(role_id)
);

CREATE TABLE security.permissions (
  permission_id   SERIAL PRIMARY KEY,
  permission_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE security.role_permissions (
  role_id       INT REFERENCES security.roles(role_id),
  permission_id INT REFERENCES security.permissions(permission_id),
  PRIMARY KEY (role_id, permission_id)
);

INSERT INTO security.roles (role_name) 
VALUES ('cashier'),
       ('admin');

INSERT INTO security.permissions (permission_name) 
VALUES ('check tickets'),
       ('edit schedule');

INSERT INTO security.role_permissions (role_id, permission_id) 
VALUES (1, 1),
       (2, 1),
       (2, 2);
