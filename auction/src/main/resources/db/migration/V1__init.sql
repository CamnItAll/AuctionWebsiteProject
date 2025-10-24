CREATE TABLE users (
id INTEGER PRIMARY KEY AUTOINCREMENT,
username TEXT UNIQUE NOT NULL,
password_hash TEXT NOT NULL,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
address_street TEXT NOT NULL,
address_no TEXT NOT NULL,
city TEXT NOT NULL,
country TEXT NOT NULL,
postal_code TEXT NOT NULL,
created_at TEXT NOT NULL
);
CREATE INDEX idx_users_username ON users(username);