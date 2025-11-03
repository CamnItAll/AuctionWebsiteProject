CREATE DATABASE IF NOT EXISTS auction_site DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE auction_site;

CREATE TABLE IF NOT EXISTS users (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	first_name VARCHAR(80) NOT NULL,
	last_name VARCHAR(80) NOT NULL,
	address_street VARCHAR(80) NOT NULL,
	address_no VARCHAR(80) NOT NULL,
	city VARCHAR(80) NOT NULL,
	country VARCHAR(80) NOT NULL,
	postal_code VARCHAR(80) NOT NULL,
	created_at VARCHAR(255) NOT NULL
	);
	
CREATE TABLE IF NOT EXISTS items (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) UNIQUE NOT NULL,
	description VARCHAR(255) NOT NULL,
	start_price DOUBLE NOT NULL,
	current_price DOUBLE NOT NULL,
	auction_status VARCHAR(6) NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
	auction_type ENUM('FORWARD', 'DUTCH'),
	expedited_shipping_price DOUBLE NOT NULL,
	shipping_days INTEGER NOT NULL,
    owner_id INTEGER NOT NULL,
    highest_bidder_id INTEGER,
    FOREIGN KEY (owner_id) REFERENCES users(id),
    FOREIGN KEY (highest_bidder_id) REFERENCES users(id)
	);
	
CREATE TABLE IF NOT EXISTS bids (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	item_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	amount DOUBLE NOT NULL,
	bid_date TIMESTAMP NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
	);
    
CREATE TABLE IF NOT EXISTS payments (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	buyer_id INTEGER NOT NULL,
	item_id INTEGER NOT NULL,
	amount_paid DOUBLE NOT NULL,
	card_num VARCHAR(19) NOT NULL,
    card_name VARCHAR(99) NOT NULL,
    expire_date VARCHAR(6) NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    payment_date TIMESTAMP NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES users(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
	);