-- 创建电影主表
DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `director` varchar(100) NOT NULL,
  `duration` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `releaseYear` int NOT NULL,
  `rating` varchar(10) NOT NULL,
  `description` text,
  `image` varchar(255),
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建演员表
DROP TABLE IF EXISTS `movie_cast`;
CREATE TABLE `movie_cast` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `cast_member` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建评分表
DROP TABLE IF EXISTS `movie_reviews`;
CREATE TABLE `movie_reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `imdb` varchar(20),
  `rottenTomatoes` varchar(20),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建亮点表
DROP TABLE IF EXISTS `movie_highlights`;
CREATE TABLE `movie_highlights` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `highlight` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建电影票表
DROP TABLE IF EXISTS `movie_tickets`;
CREATE TABLE `movie_tickets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `user_id` int NOT NULL,
  `seat_numbers` JSON NOT NULL,
  `paid_price` decimal(10,2) NOT NULL,
  `screening_time` datetime NOT NULL,
  `purchase_time` timestamp DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending', 'paid', 'used', 'cancelled') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建用户评分表
DROP TABLE IF EXISTS `user_ratings`;
CREATE TABLE `user_ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `rating` decimal(2,1) NOT NULL CHECK (rating >= 0 AND rating <= 5),
  `comment` text,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_movie_rating` (`user_id`, `movie_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 创建管理员表
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 插入示例数据
INSERT INTO `movies` 
(`title`, `genre`, `director`, `duration`, `price`, `releaseYear`, `rating`, `description`, `image`) 
VALUES 
('The Dark Knight', 'Action/Crime/Drama', 'Christopher Nolan', '2h 32min', 16.00, 2008, 'PG-13', 
'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
'images/The Dark Knight.jpg');

-- 获取最后插入的电影ID
SET @movie_id = LAST_INSERT_ID();

-- 插入演员数据
INSERT INTO `movie_cast` (`movie_id`, `cast_member`) VALUES
(@movie_id, 'Christian Bale as Bruce Wayne/Batman'),
(@movie_id, 'Heath Ledger as The Joker'),
(@movie_id, 'Aaron Eckhart as Harvey Dent'),
(@movie_id, 'Michael Caine as Alfred'),
(@movie_id, 'Gary Oldman as Jim Gordon');

-- 插入评分数据
INSERT INTO `movie_reviews` (`movie_id`, `imdb`, `rottenTomatoes`) VALUES
(@movie_id, '9.0/10', '94%');

-- 插入亮点数据
INSERT INTO `movie_highlights` (`movie_id`, `highlight`) VALUES
(@movie_id, 'Heath Ledger\'s legendary Joker performance'),
(@movie_id, 'Complex moral themes'),
(@movie_id, 'Revolutionary IMAX sequences'),
(@movie_id, 'Oscar-winning achievements');

-- 插入示例管理员数据 (密码: admin123)
INSERT INTO `admins` (`username`, `password`, `email`) VALUES
('admin', '$2b$10$PUZpAv/hQhRwZGQrMuFYG.zVwJ0mZ9K8j8yqZZ3ZX3ZX3ZX3ZX3Z', 'admin@example.com');
