CREATE DATABASE IF NOT EXISTS loginmvc_db;
USE loginmvc_db;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(30)
);

INSERT INTO users (username, password)
VALUES ('admin', '1234')
ON DUPLICATE KEY UPDATE password = VALUES(password);

INSERT INTO clients (first_name, last_name, email, phone)
VALUES
    ('Ahmed', 'Ben Ali', 'ahmed.benali@example.com', '20111222'),
    ('Sarra', 'Trabelsi', 'sarra.trabelsi@example.com', '50123456'),
    ('Youssef', 'Mansouri', 'youssef.mansouri@example.com', '92111222')
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    last_name = VALUES(last_name),
    phone = VALUES(phone);
