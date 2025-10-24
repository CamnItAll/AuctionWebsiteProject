CREATE DATABASE IF NOT EXISTS auction_site DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE auction_site;

CREATE TABLE IF NOT EXISTS users (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(255) UNIQUE NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	first_name VARCHAR(80) NOT NULL,
	last_name VARCHAR(80) NOT NULL,
	address_street VARCHAR(80) NOT NULL,
	address_no VARCHAR(80) NOT NULL,
	city VARCHAR(80) NOT NULL,
	country VARCHAR(80) NOT NULL,
	postal_code VARCHAR(80) NOT NULL,
	created_at VARCHAR(255) NOT NULL
);

CREATE INDEX idx_users_username ON users(username);
