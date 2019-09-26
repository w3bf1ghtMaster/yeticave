INSERT INTO `users` (`email`, `password`, `name`, `contact_info`, `creation_time`)
VALUES ('Ivanich@mail.ru', 'ivan123', 'Ivan', 'Mobile phone: +79008008844', NOW()),
       ('Petrovich@mail.ru', 'petr123', 'Petr', 'Mobile phone: +79008007733', NOW());

INSERT INTO `categories` (`name`, `code`)
VALUES ('Доски и лыжи', 'boards'),
       ('Крепления', 'attachment'),
       ('Ботинки', 'boots'),
       ('Одежда', 'clothing'),
       ('Инструменты', 'tools'),
       ('Разное', 'other');

INSERT INTO `cards` (`title`, `image`, `description`, `base_price`, `step_bid`, `user_id`, `winner_id`, `category_id`, `creation_time`, `end_time`)
VALUES ('2014 Rossignol District Snowboard', '/img/lot-1.jpg', 'Идеальный сноуборд', '10999', '500', '1', NULL, '1', NOW(), '2019-12-01'),
       ('DC Ply Mens 2016/2017 Snowboard', '/img/lot-2.jpg', 'Чудесный сноуборд', '159999', '1500', '1', NULL, '1', NOW(), '2019-12-01'),
       ('Крепления Union Contact Pro 2015 года размер L/XL', '/img/lot-3.jpg', 'Супер крепление', '8000', '2500', '2', NULL, '2', NOW(), '2019-12-01'),
       ('Ботинки для сноуборда DC Mutiny Charocal', '/img/lot-4.jpg', 'Дорогие ботинки', '10999', '500', '1', NULL, '3', NOW(), '2019-12-01'),
       ('Куртка для сноуборда DC Mutiny Charocal', '/img/lot-5.jpg', 'Дешевая куртка', '7500', '1500', '2', NULL, '4', NOW(), '2019-12-01'),
       ('Маска Oakley Canopy', '/img/lot-6.jpg', 'Нормальная маска', '5400', '2500', '2', NULL, '6', NOW(), '2019-12-01');

INSERT INTO `bids` (`user_id`, `card_id`, `current_price`, `creation_time`)
VALUES ('1', '1', '11499', NOW()),
       ('2', '1', '11999', NOW()),
       ('1', '2', '162999', NOW()),
       ('2', '2', '165999', NOW()),
       ('2', '6', '7900', NOW()),
       ('1', '6', '10400', NOW());

-- Получить все категории;
SELECT name FROM `categories`;

-- Получить самые новые, открытые лоты. Каждый лот должен включать название, стартовую цену, ссылку на изображение, цену, название категории;
SELECT cards.id, title, base_price, image, (SELECT current_price FROM bids WHERE card_id = cards.id ORDER BY id DESC LIMIT 1), c.name, cards.creation_time FROM cards
JOIN categories c ON cards.category_id = c.id
WHERE cards.end_time > NOW()
ORDER BY creation_time DESC;

-- Показать лот по его id, получить название категории этого лота;
SELECT cards.* , c.name FROM cards
JOIN categories c ON category_id = c.id
WHERE cards.id = 2;

-- Обновить название лота по его индентификатору;
UPDATE cards SET title = '2014 Rossingnol Disctrict Snowboard'
WHERE id = 1;

-- Получить список самых свежих ставок для лота по его индентификатору;
SELECT * FROM bids WHERE card_id = 1 ORDER BY creation_time DESC;
