CREATE SCHEMA security;

CREATE TABLE security.users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role_id INT REFERENCES security.roles(role_id)
);

CREATE TABLE security.roles (
  role_id SERIAL PRIMARY KEY,
  role_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE security.permissions (
  permission_id SERIAL PRIMARY KEY,
  permission_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE security.role_permissions (
  role_id INT REFERENCES security.roles(role_id),
  permission_id INT REFERENCES security.permissions(permission_id),
  PRIMARY KEY (role_id, permission_id)
);

-- Добавление ролей
INSERT INTO security.roles (role_name) VALUES ('cashier');
INSERT INTO security.roles (role_name) VALUES ('admin');

-- Добавление прав доступа
INSERT INTO security.permissions (permission_name) VALUES ('check trains');
INSERT INTO security.permissions (permission_name) VALUES ('edit schedule');

-- Назначение прав доступа для ролей
INSERT INTO security.role_permissions (role_id, permission_id) VALUES (1, 1); -- роль "кассир" имеет право "просмотр поездов"
INSERT INTO security.role_permissions (role_id, permission_id) VALUES (2, 1); -- роль "администратор" имеет право "просмотр поездов"
INSERT INTO security.role_permissions (role_id, permission_id) VALUES (2, 2); -- роль "администратор" имеет право "редактирование расписания"
