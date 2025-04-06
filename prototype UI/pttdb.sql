/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : pttdb

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 22/12/2024 22:45:42
*/
-- 创建数据库
DROP DATABASE IF EXISTS `pttdb`;
CREATE DATABASE `pttdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- 使用数据库
USE `pttdb`;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (1, 'admin', 'admin123', '2024-12-21 18:39:00');

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'API操作类型',
  `details` json NULL COMMENT '操作详细信息',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作用户',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logs
-- ----------------------------
INSERT INTO `logs` VALUES (1, 'GET_USERS', '{\"count\": 3}', 'admin', '2024-12-22 13:52:10');
INSERT INTO `logs` VALUES (2, 'GET_USERS', '{\"count\": 3}', 'admin', '2024-12-22 13:52:22');
INSERT INTO `logs` VALUES (3, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:53:12');
INSERT INTO `logs` VALUES (4, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:53:40');
INSERT INTO `logs` VALUES (5, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:53:42');
INSERT INTO `logs` VALUES (6, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:53:48');
INSERT INTO `logs` VALUES (7, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:54:00');
INSERT INTO `logs` VALUES (8, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:54:55');
INSERT INTO `logs` VALUES (9, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 13:54:55');
INSERT INTO `logs` VALUES (10, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 13:55:02');
INSERT INTO `logs` VALUES (11, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:55:02');
INSERT INTO `logs` VALUES (12, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 13:56:29');
INSERT INTO `logs` VALUES (13, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:56:29');
INSERT INTO `logs` VALUES (14, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:57:20');
INSERT INTO `logs` VALUES (15, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 13:57:20');
INSERT INTO `logs` VALUES (16, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 13:58:22');
INSERT INTO `logs` VALUES (17, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:58:22');
INSERT INTO `logs` VALUES (18, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 13:59:13');
INSERT INTO `logs` VALUES (19, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:59:13');
INSERT INTO `logs` VALUES (20, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 13:59:26');
INSERT INTO `logs` VALUES (21, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 13:59:26');
INSERT INTO `logs` VALUES (22, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 14:00:54');
INSERT INTO `logs` VALUES (23, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 14:00:54');
INSERT INTO `logs` VALUES (24, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 14:01:11');
INSERT INTO `logs` VALUES (25, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 14:01:11');
INSERT INTO `logs` VALUES (26, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 14:02:14');
INSERT INTO `logs` VALUES (27, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 14:02:14');
INSERT INTO `logs` VALUES (28, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 14:03:35');
INSERT INTO `logs` VALUES (29, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 14:03:35');
INSERT INTO `logs` VALUES (30, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 14:31:28');
INSERT INTO `logs` VALUES (31, 'SEARCH_USERS', '{\"count\": 1, \"searchTerm\": \"user1333\"}', 'admin', '2024-12-22 14:31:33');
INSERT INTO `logs` VALUES (32, 'SEARCH_USERS', '{\"count\": 2, \"searchTerm\": \"\"}', 'admin', '2024-12-22 14:31:35');
INSERT INTO `logs` VALUES (33, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 14:31:41');
INSERT INTO `logs` VALUES (34, 'GET_USERS', '{\"count\": 2}', 'admin', '2024-12-22 14:31:41');
INSERT INTO `logs` VALUES (35, 'GET_USERS', NULL, 'admin', '2024-12-22 14:38:58');
INSERT INTO `logs` VALUES (36, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-22 14:38:58');
INSERT INTO `logs` VALUES (37, 'GET_USERS', NULL, 'admin', '2024-12-22 14:40:40');
INSERT INTO `logs` VALUES (38, 'SEARCH_USERS', NULL, 'admin', '2024-12-22 14:40:42');
INSERT INTO `logs` VALUES (39, 'SEARCH_USERS', NULL, 'admin', '2024-12-22 14:40:47');
INSERT INTO `logs` VALUES (40, 'SEARCH_USERS', NULL, 'admin', '2024-12-22 14:40:48');
INSERT INTO `logs` VALUES (41, 'SEARCH_USERS', NULL, 'admin', '2024-12-22 14:40:50');

-- ----------------------------
-- Table structure for movie_bookings
-- ----------------------------
DROP TABLE IF EXISTS `movie_bookings`;
CREATE TABLE `movie_bookings`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `booking_time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `movie_bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `movie_bookings_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_bookings
-- ----------------------------
INSERT INTO `movie_bookings` VALUES (8, 5, 1, '2024-12-22 14:38:52', '2024-12-22 14:38:52');

-- ----------------------------
-- Table structure for movie_cast
-- ----------------------------
DROP TABLE IF EXISTS `movie_cast`;
CREATE TABLE `movie_cast`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `actor_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_cast
-- ----------------------------
INSERT INTO `movie_cast` VALUES (1, 1, 'Robert Downey Jr.', 'Iron Man');
INSERT INTO `movie_cast` VALUES (2, 1, 'Chris Evans', 'Captain America');
INSERT INTO `movie_cast` VALUES (3, 1, 'Scarlett Johansson', 'Black Widow');
INSERT INTO `movie_cast` VALUES (4, 1, 'Chris Hemsworth', 'Thor');
INSERT INTO `movie_cast` VALUES (5, 1, 'Mark Ruffalo', 'Hulk');
INSERT INTO `movie_cast` VALUES (6, 2, 'Leonardo DiCaprio', 'Cobb');
INSERT INTO `movie_cast` VALUES (7, 2, 'Joseph Gordon-Levitt', 'Arthur');
INSERT INTO `movie_cast` VALUES (8, 2, 'Ellen Page', 'Ariadne');
INSERT INTO `movie_cast` VALUES (9, 2, 'Tom Hardy', 'Eames');
INSERT INTO `movie_cast` VALUES (10, 2, 'Ken Watanabe', 'Saito');
INSERT INTO `movie_cast` VALUES (11, 3, 'Tom Holland', 'Peter Parker/Spider-Man');
INSERT INTO `movie_cast` VALUES (12, 3, 'Zendaya', 'MJ');
INSERT INTO `movie_cast` VALUES (13, 3, 'Benedict Cumberbatch', 'Doctor Strange');
INSERT INTO `movie_cast` VALUES (14, 3, 'Jacob Batalon', 'Ned Leeds');
INSERT INTO `movie_cast` VALUES (15, 3, 'Marisa Tomei', 'May Parker');

-- ----------------------------
-- Table structure for movie_highlights
-- ----------------------------
DROP TABLE IF EXISTS `movie_highlights`;
CREATE TABLE `movie_highlights`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `highlight_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `movie_highlights_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_highlights
-- ----------------------------
INSERT INTO `movie_highlights` VALUES (1, 1, 'Epic conclusion to the Infinity Saga');
INSERT INTO `movie_highlights` VALUES (2, 1, 'Groundbreaking special effects');
INSERT INTO `movie_highlights` VALUES (3, 1, 'Emotional character arcs');
INSERT INTO `movie_highlights` VALUES (4, 1, 'Record-breaking box office success');
INSERT INTO `movie_highlights` VALUES (5, 2, 'Mind-bending plot');
INSERT INTO `movie_highlights` VALUES (6, 2, 'Oscar-winning visual effects');
INSERT INTO `movie_highlights` VALUES (7, 2, 'Hans Zimmer\'s iconic score');
INSERT INTO `movie_highlights` VALUES (8, 2, 'Complex narrative structure');
INSERT INTO `movie_highlights` VALUES (9, 3, 'Multiverse storyline');
INSERT INTO `movie_highlights` VALUES (10, 3, 'Fan service moments');
INSERT INTO `movie_highlights` VALUES (11, 3, 'Emotional performances');
INSERT INTO `movie_highlights` VALUES (12, 3, 'Spectacular action sequences');

-- ----------------------------
-- Table structure for movie_reviews
-- ----------------------------
DROP TABLE IF EXISTS `movie_reviews`;
CREATE TABLE `movie_reviews`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `score` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `movie_reviews_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_reviews
-- ----------------------------
INSERT INTO `movie_reviews` VALUES (1, 1, 'IMDb', '8.4/10');
INSERT INTO `movie_reviews` VALUES (2, 1, 'Rotten Tomatoes', '94%');
INSERT INTO `movie_reviews` VALUES (3, 2, 'IMDb', '8.8/10');
INSERT INTO `movie_reviews` VALUES (4, 2, 'Rotten Tomatoes', '87%');
INSERT INTO `movie_reviews` VALUES (5, 3, 'IMDb', '8.2/10');
INSERT INTO `movie_reviews` VALUES (6, 3, 'Rotten Tomatoes', '93%');

-- ----------------------------
-- Table structure for movie_type_relations
-- ----------------------------
DROP TABLE IF EXISTS `movie_type_relations`;
CREATE TABLE `movie_type_relations`  (
  `movie_id` int NOT NULL,
  `type_id` int NOT NULL,
  PRIMARY KEY (`movie_id`, `type_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `movie_type_relations_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `movie_type_relations_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `movie_types` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_type_relations
-- ----------------------------

-- ----------------------------
-- Table structure for movie_types
-- ----------------------------
DROP TABLE IF EXISTS `movie_types`;
CREATE TABLE `movie_types`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_types
-- ----------------------------
INSERT INTO `movie_types` VALUES (1, 'Action');
INSERT INTO `movie_types` VALUES (8, 'Animation');
INSERT INTO `movie_types` VALUES (2, 'Comedy');
INSERT INTO `movie_types` VALUES (7, 'Documentary');
INSERT INTO `movie_types` VALUES (3, 'Drama');
INSERT INTO `movie_types` VALUES (10, 'Fantasy');
INSERT INTO `movie_types` VALUES (4, 'Horror');
INSERT INTO `movie_types` VALUES (6, 'Romance');
INSERT INTO `movie_types` VALUES (5, 'Science Fiction');
INSERT INTO `movie_types` VALUES (9, 'Thriller');

-- ----------------------------
-- Table structure for movies
-- ----------------------------
DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `genre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `director` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `duration` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `release_year` int NOT NULL,
  `rating` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movies
-- ----------------------------
INSERT INTO `movies` VALUES (1, 'Avengers: Endgame', 'Action', 'Anthony and Joe Russo', '3', 20.00, 2019, '123', 'After Thanos\' devastating snap, the remaining Avengers must reunite for one final mission to restore balance to the universe and bring back their vanquished allies.', 'images/avengers.jpg', '2024-12-21 18:25:02');
INSERT INTO `movies` VALUES (2, 'Inception', 'Animation', 'Christopher Nolan', '2', 15.00, 2010, '1', 'A skilled thief who specializes in extracting information from people\'s minds during their dreams takes on an impossible mission: planting an idea into someone\'s subconscious.', 'images/inception.jpg', '2024-12-21 18:25:02');
INSERT INTO `movies` VALUES (3, 'Spider-Man: No Way Home', 'Drama', 'Jon Watts', '2', 18.00, 2021, '1', 'When Peter Parker\'s identity as Spider-Man is revealed, he seeks help from Doctor Strange, leading to a dangerous journey that forces him to discover what it truly means to be Spider-Man.', 'images/spiderman.jpg', '2024-12-21 18:25:02');

-- ----------------------------
-- Table structure for promotions
-- ----------------------------
DROP TABLE IF EXISTS `promotions`;
CREATE TABLE `promotions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `discount` decimal(5, 2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotions
-- ----------------------------
INSERT INTO `promotions` VALUES (2, '123', 21.00, '2024-12-05', '2024-12-14', '2024-12-22 13:04:10', '2024-12-22 13:04:10');
INSERT INTO `promotions` VALUES (4, '213', 1.00, '2024-11-30', '2024-12-07', '2024-12-22 13:42:50', '2024-12-22 13:42:50');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (3, 'user1333', 'user', 'use1r@qq11.com', '2024-12-22 10:27:35');
INSERT INTO `users` VALUES (5, 'user2', 'user2', 'user2@qq.com', '2024-12-22 11:53:50');

SET FOREIGN_KEY_CHECKS = 1;
