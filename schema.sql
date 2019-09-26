DROP DATABASE IF EXISTS yeticave;

CREATE DATABASE yeticave
 DEFAULT CHARACTER SET utf8
 DEFAULT COLLATE utf8_general_ci;

USE yeticave;

CREATE TABLE `users` (
    `id` INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(128) NOT NULL,
    `password` VARCHAR(64) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `contact_info` VARCHAR(255) NOT NULL,
    `creation_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `categories` (
    `id` INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(64) NOT NULL,
    `code` VARCHAR(64) NOT NULL
);

CREATE TABLE `cards` (
    `id` INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(128) NOT NULL,
    `image` VARCHAR(128),
    `description` TEXT,
    `base_price` INT(11) UNSIGNED NOT NULL,
    `step_bid` INT(11) UNSIGNED NOT NULL,
    `user_id` INT(11) UNSIGNED NOT NULL,
    `winner_id` INT(11) UNSIGNED,
    `category_id` INT(11) UNSIGNED NOT NULL,
    `creation_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `end_time` DATETIME NOT NULL,
    FULLTEXT KEY `idx_cards_title` (`title`),
    FULLTEXT KEY `idx_cards_description` (`description`),
    CONSTRAINT `fk_cards_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_cards_winner` FOREIGN KEY (`winner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_cards_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `bids` (
    `id` INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT(11) UNSIGNED NOT NULL,
    `card_id` INT(11) UNSIGNED NOT NULL,
    `current_price` INT(11) UNSIGNED NOT NULL,
    `creation_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_bids_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_bids_card` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE INDEX name_idx ON users(name);
CREATE UNIQUE INDEX email_udx ON users(email);
CREATE UNIQUE INDEX name_udx ON categories(name);
CREATE INDEX title_udx ON cards(title);
CREATE INDEX description_idx ON cards(description(1000));
CREATE INDEX creation_time_idx ON bids(creation_time);
