DROP DATABASE IF EXISTS yeticave;

CREATE DATABASE yeticave
 DEFAULT CHARACTER SET utf8
 DEFAULT COLLATE utf8_general_ci;

USE yeticave;

CREATE TABLE users (
    id INT UNSINGED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(128) NOT NULL,
    password VARCHAR(64) NOT NULL,
    name VARCHAR(64) NOT NULL,
    contact_info VARCHAR(255) NOT NULL,
    creation_time DATATIME NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE INDEX name_idx ON users(name);
CREATE UNIQUE INDEX email_udx ON users(email);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    code VARCHAR(64) NOT NULL
)

CREATE UNIQUE INDEX name_udx ON categories(name);

CREATE TABLE cards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    image VARCHAR(128),
    description TEXT,
    base_price INT(11) UNSINGED NOT NULL,
    step_bid INT(11) UNSINGED NOT NULL,
    user_id INT(11) UNSINGED NOT NULL,
    winner_id INT(11) UNSINGED,
    category_id INT(11) UNSINGED NOT NULL,
    creation_time DATATIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time DATATIME NOT NULL
)

CREATE INDEX title_udx ON cards(title);
CREATE INDEX description_idx ON cards(description);

ALTER TABLE cards
    ADD FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE cards
    ADD FOREIGN KEY (winner_id)
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE cards
    ADD FOREIGN KEY (category_id)
        REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE bids (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT(11) UNSINGED NOT NULL,
    card_id INT(11) UNSINGED NOT NULL,
    amount INT(11) NOT NULL,
    creation_time DATATIME NOT NULL DEFAULT CURRENT_TIMESTAMP
)

CREATE INDEX creation_time_idx ON bids(creation_time);

ALTER TABLE bids
    ADD FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE bids
    ADD FOREIGN KEY (card_id)
        REFERENCES cards(id) ON DELETE CASCADE ON UPDATE CASCADE;
