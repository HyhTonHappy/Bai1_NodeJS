-- Create tables
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

CREATE TABLE restaurant (
    res_id INT AUTO_INCREMENT PRIMARY KEY,
    res_name VARCHAR(255),
    image VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE food_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(255)
);

CREATE TABLE food (
    food_id INT AUTO_INCREMENT PRIMARY KEY,
    food_name VARCHAR(255),
    image VARCHAR(255),
    price FLOAT,
    description VARCHAR(255),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);

CREATE TABLE sub_food (
    sub_id INT AUTO_INCREMENT PRIMARY KEY,
    sub_name VARCHAR(255),
    sub_price FLOAT,
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE `order` (
    user_id INT,
    food_id INT,
    amount INT,
    code VARCHAR(255),
    arr_sub_id VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

CREATE TABLE like_res (
    user_id INT,
    res_id INT,
    date_like DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

CREATE TABLE rate_res (
    user_id INT,
    res_id INT,
    amount INT,
    date_rate DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
);

-- Insert sample values
INSERT INTO user (full_name, email, password) VALUES
('John Doe', 'john.doe@example.com', 'password123'),
('Jane Smith', 'jane.smith@example.com', 'password456');

INSERT INTO restaurant (res_name, image, description) VALUES
('Gourmet Paradise', 'paradise.jpg', 'Fine dining experience'),
('Quick Eats', 'quick_eats.jpg', 'Fast food chain');

INSERT INTO food_type (type_name) VALUES
('Vegetarian'),
('Non-Vegetarian');

INSERT INTO food (food_name, image, price, description, type_id) VALUES
('Veg Burger', 'veg_burger.jpg', 5.99, 'Delicious veggie burger', 1),
('Chicken Burger', 'chicken_burger.jpg', 6.99, 'Juicy chicken burger', 2);

INSERT INTO sub_food (sub_name, sub_price, food_id) VALUES
('Extra Cheese', 1.50, 1),
('Spicy Sauce', 0.75, 2);

INSERT INTO `order` (user_id, food_id, amount, code, arr_sub_id) VALUES
(1, 1, 2, 'ORD123', '1'),
(2, 2, 1, 'ORD124', '2');

INSERT INTO like_res (user_id, res_id, date_like) VALUES
(1, 1, '2025-01-18 10:00:00'),
(2, 2, '2025-01-18 11:00:00');

INSERT INTO rate_res (user_id, res_id, amount, date_rate) VALUES
(1, 1, 5, '2025-01-18 12:00:00'),
(2, 2, 4, '2025-01-18 13:00:00');


-- câu 1
select count(u.user_id) as cnt_user, u.user_id, u.full_name
from user as u
join like_res on like_res.user_id = u.user_id
GROUP by u.user_id, u.full_name
order by cnt_user desc
LIMIT 5;

-- câu 2
select count(res.res_id) as cnt_res, res.res_id, res.res_name
from restaurant as res
join like_res on like_res.res_id = res.res_id
GROUP BY res.res_id, res.res_name
order by cnt_res desc
LIMIT 2

-- câu 3
select count(ord.user_id) as cnt_ord, u.user_id, u.full_name
from `order` as ord
join user as u where u.user_id = ord.user_id
GROUP BY u.user_id, u.full_name
ORDER BY cnt_ord desc
limit 1

-- câu 4
select u.user_id, u.full_name from user as u
left join `order` as ord on ord.user_id = u.user_id
left join like_res as lr on lr.user_id = u.user_id
left join rate_res as rr on rr.user_id = u.user_id
where ord.user_id is null and lr.user_id is null and rr.user_id is null
