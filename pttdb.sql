/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 127.0.0.1:3306
 Source Schema         : pttdb

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 31/12/2024 17:36:14
*/

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 320 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统操作日志' ROW_FORMAT = Dynamic;

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
INSERT INTO `logs` VALUES (42, 'GET_USERS', NULL, 'admin', '2024-12-29 02:20:39');
INSERT INTO `logs` VALUES (43, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 02:20:39');
INSERT INTO `logs` VALUES (44, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 02:20:48');
INSERT INTO `logs` VALUES (45, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 02:20:49');
INSERT INTO `logs` VALUES (46, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 02:20:52');
INSERT INTO `logs` VALUES (47, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 02:22:00');
INSERT INTO `logs` VALUES (48, 'GET_USERS', NULL, 'admin', '2024-12-29 02:22:00');
INSERT INTO `logs` VALUES (49, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 02:39:37');
INSERT INTO `logs` VALUES (50, 'GET_USERS', NULL, 'admin', '2024-12-29 02:39:37');
INSERT INTO `logs` VALUES (51, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 02:40:12');
INSERT INTO `logs` VALUES (52, 'GET_USERS', NULL, 'admin', '2024-12-29 02:40:12');
INSERT INTO `logs` VALUES (53, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 02:41:08');
INSERT INTO `logs` VALUES (54, 'GET_USERS', NULL, 'admin', '2024-12-29 02:41:08');
INSERT INTO `logs` VALUES (55, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 02:49:58');
INSERT INTO `logs` VALUES (56, 'GET_USERS', NULL, 'admin', '2024-12-29 02:49:58');
INSERT INTO `logs` VALUES (57, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 03:20:11');
INSERT INTO `logs` VALUES (58, 'GET_USERS', NULL, 'admin', '2024-12-29 03:20:11');
INSERT INTO `logs` VALUES (59, 'GET_USERS', NULL, 'admin', '2024-12-29 03:20:17');
INSERT INTO `logs` VALUES (60, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 03:20:17');
INSERT INTO `logs` VALUES (61, 'GET_USERS', NULL, 'admin', '2024-12-29 03:32:21');
INSERT INTO `logs` VALUES (62, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 03:32:21');
INSERT INTO `logs` VALUES (63, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 04:13:44');
INSERT INTO `logs` VALUES (64, 'GET_USERS', NULL, 'admin', '2024-12-29 04:13:44');
INSERT INTO `logs` VALUES (65, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 04:15:08');
INSERT INTO `logs` VALUES (66, 'GET_USERS', NULL, 'admin', '2024-12-29 04:15:08');
INSERT INTO `logs` VALUES (67, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 04:16:04');
INSERT INTO `logs` VALUES (68, 'GET_USERS', NULL, 'admin', '2024-12-29 04:16:04');
INSERT INTO `logs` VALUES (69, 'GET_USERS', NULL, 'admin', '2024-12-29 04:25:04');
INSERT INTO `logs` VALUES (70, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 04:25:04');
INSERT INTO `logs` VALUES (71, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 04:45:01');
INSERT INTO `logs` VALUES (72, 'GET_USERS', NULL, 'admin', '2024-12-29 04:45:01');
INSERT INTO `logs` VALUES (73, 'GET_USERS', NULL, 'admin', '2024-12-29 04:46:07');
INSERT INTO `logs` VALUES (74, 'GET_USERS', NULL, 'admin', '2024-12-29 04:46:09');
INSERT INTO `logs` VALUES (75, 'GET_USERS', NULL, 'admin', '2024-12-29 04:46:09');
INSERT INTO `logs` VALUES (76, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 04:46:13');
INSERT INTO `logs` VALUES (77, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 04:46:15');
INSERT INTO `logs` VALUES (78, 'GET_USERS', NULL, 'admin', '2024-12-29 05:32:07');
INSERT INTO `logs` VALUES (79, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 05:32:07');
INSERT INTO `logs` VALUES (80, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 05:56:20');
INSERT INTO `logs` VALUES (81, 'GET_USERS', NULL, 'admin', '2024-12-29 05:56:20');
INSERT INTO `logs` VALUES (82, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 05:57:54');
INSERT INTO `logs` VALUES (83, 'GET_USERS', NULL, 'admin', '2024-12-29 05:57:54');
INSERT INTO `logs` VALUES (84, 'GET_USERS', NULL, 'admin', '2024-12-29 07:23:42');
INSERT INTO `logs` VALUES (85, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 07:23:42');
INSERT INTO `logs` VALUES (86, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 07:26:01');
INSERT INTO `logs` VALUES (87, 'GET_USERS', NULL, 'admin', '2024-12-29 07:26:01');
INSERT INTO `logs` VALUES (88, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 07:59:57');
INSERT INTO `logs` VALUES (89, 'GET_USERS', NULL, 'admin', '2024-12-29 07:59:57');
INSERT INTO `logs` VALUES (90, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 08:00:16');
INSERT INTO `logs` VALUES (91, 'GET_USERS', NULL, 'admin', '2024-12-29 08:00:16');
INSERT INTO `logs` VALUES (92, 'GET_USERS', NULL, 'admin', '2024-12-29 08:44:24');
INSERT INTO `logs` VALUES (93, 'GET_USERS', NULL, 'admin', '2024-12-29 08:44:24');
INSERT INTO `logs` VALUES (94, 'GET_USERS', NULL, 'admin', '2024-12-29 08:53:44');
INSERT INTO `logs` VALUES (95, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 08:53:44');
INSERT INTO `logs` VALUES (96, 'GET_USERS', NULL, 'admin', '2024-12-29 09:17:52');
INSERT INTO `logs` VALUES (97, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 09:17:52');
INSERT INTO `logs` VALUES (98, 'GET_USERS', NULL, 'admin', '2024-12-29 09:22:15');
INSERT INTO `logs` VALUES (99, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 09:22:15');
INSERT INTO `logs` VALUES (100, 'GET_USERS', NULL, 'admin', '2024-12-29 10:25:52');
INSERT INTO `logs` VALUES (101, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 10:25:52');
INSERT INTO `logs` VALUES (102, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 10:28:42');
INSERT INTO `logs` VALUES (103, 'GET_USERS', NULL, 'admin', '2024-12-29 10:28:42');
INSERT INTO `logs` VALUES (104, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 10:51:04');
INSERT INTO `logs` VALUES (105, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 10:51:07');
INSERT INTO `logs` VALUES (106, 'CREATE_BOOKING', '{\"userId\": 6, \"movieId\": 1, \"userName\": null, \"bookingId\": 11, \"createdAt\": \"2024-12-29T11:33:20.099Z\", \"movieTitle\": \"The Dark Knight\", \"totalPrice\": 32, \"seatNumbers\": [\"2-7\", \"2-5\"]}', NULL, '2024-12-29 11:33:20');
INSERT INTO `logs` VALUES (107, 'CANCEL_BOOKING', '{\"userId\": 6, \"movieId\": null, \"showTime\": null, \"userName\": null, \"bookingId\": null, \"createdAt\": \"2024-12-29T11:33:31.622Z\", \"movieTitle\": null, \"totalPrice\": null, \"seatNumbers\": null}', NULL, '2024-12-29 11:33:31');
INSERT INTO `logs` VALUES (108, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 11:33:42');
INSERT INTO `logs` VALUES (109, 'GET_USERS', NULL, 'admin', '2024-12-29 11:33:42');
INSERT INTO `logs` VALUES (110, 'GET_USERS', NULL, 'admin', '2024-12-29 11:33:50');
INSERT INTO `logs` VALUES (111, 'SEARCH_USERS', NULL, 'admin', '2024-12-29 11:34:49');
INSERT INTO `logs` VALUES (112, 'GET_PROMOTIONS', '{\"count\": 2}', NULL, '2024-12-29 11:34:55');
INSERT INTO `logs` VALUES (113, 'GET_USERS', NULL, 'admin', '2024-12-29 11:34:55');
INSERT INTO `logs` VALUES (114, 'GET_PROMOTION', '{\"id\": \"4\"}', NULL, '2024-12-29 11:55:27');
INSERT INTO `logs` VALUES (115, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 7, \"name\": \"21333\", \"discount\": 1, \"end_date\": \"2024-12-07\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:55:29');
INSERT INTO `logs` VALUES (116, 'UPDATE_PROMOTION', '{\"id\": \"4\", \"updates\": {\"name\": \"21333\", \"discount\": 1, \"end_date\": \"2024-12-07\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:55:29');
INSERT INTO `logs` VALUES (117, 'GET_PROMOTIONS', '{\"count\": 3}', NULL, '2024-12-29 11:55:31');
INSERT INTO `logs` VALUES (118, 'GET_PROMOTIONS', '{\"count\": 3}', NULL, '2024-12-29 11:55:32');
INSERT INTO `logs` VALUES (119, 'GET_PROMOTION', '{\"id\": \"7\"}', NULL, '2024-12-29 11:55:35');
INSERT INTO `logs` VALUES (120, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 8, \"name\": \"2133344\", \"discount\": 1, \"end_date\": \"2024-12-07\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:55:37');
INSERT INTO `logs` VALUES (121, 'UPDATE_PROMOTION', '{\"id\": \"7\", \"updates\": {\"name\": \"2133344\", \"discount\": 1, \"end_date\": \"2024-12-07\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:55:37');
INSERT INTO `logs` VALUES (122, 'GET_PROMOTIONS', '{\"count\": 4}', NULL, '2024-12-29 11:55:38');
INSERT INTO `logs` VALUES (123, 'GET_PROMOTIONS', '{\"count\": 4}', NULL, '2024-12-29 11:55:39');
INSERT INTO `logs` VALUES (124, 'GET_PROMOTION', '{\"id\": \"8\"}', NULL, '2024-12-29 11:55:43');
INSERT INTO `logs` VALUES (125, 'UPDATE_PROMOTION', '{\"id\": \"8\", \"updates\": {\"name\": \"2133344\", \"discount\": 1, \"end_date\": \"2024-12-07\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:55:45');
INSERT INTO `logs` VALUES (126, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 9, \"name\": \"2133344\", \"discount\": 1, \"end_date\": \"2024-12-07\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:55:45');
INSERT INTO `logs` VALUES (127, 'GET_PROMOTIONS', '{\"count\": 5}', NULL, '2024-12-29 11:56:37');
INSERT INTO `logs` VALUES (128, 'GET_PROMOTIONS', '{\"count\": 5}', NULL, '2024-12-29 11:56:55');
INSERT INTO `logs` VALUES (129, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 10, \"name\": \"13\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:57:07');
INSERT INTO `logs` VALUES (130, 'UPDATE_PROMOTION', '{\"id\": \"8\", \"updates\": {\"name\": \"13\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 11:57:07');
INSERT INTO `logs` VALUES (131, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 11:57:08');
INSERT INTO `logs` VALUES (132, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 11:57:09');
INSERT INTO `logs` VALUES (133, 'GET_PROMOTION', '{\"id\": \"10\"}', NULL, '2024-12-29 11:57:23');
INSERT INTO `logs` VALUES (134, 'GET_PROMOTION', '{\"id\": \"10\"}', NULL, '2024-12-29 11:57:27');
INSERT INTO `logs` VALUES (135, 'GET_PROMOTION', '{\"id\": \"10\"}', NULL, '2024-12-29 11:57:32');
INSERT INTO `logs` VALUES (136, 'UPDATE_PROMOTION', '{\"id\": \"10\", \"updates\": {\"name\": \"13\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:03:22');
INSERT INTO `logs` VALUES (137, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 11, \"name\": \"13\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:03:22');
INSERT INTO `logs` VALUES (138, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:03:23');
INSERT INTO `logs` VALUES (139, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:05:03');
INSERT INTO `logs` VALUES (140, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:05:15');
INSERT INTO `logs` VALUES (141, 'GET_USERS', NULL, 'admin', '2024-12-29 12:05:15');
INSERT INTO `logs` VALUES (142, 'GET_PROMOTION', '{\"id\": \"11\"}', NULL, '2024-12-29 12:05:17');
INSERT INTO `logs` VALUES (143, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 12, \"name\": \"13123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:05:38');
INSERT INTO `logs` VALUES (144, 'UPDATE_PROMOTION', '{\"id\": \"11\", \"updates\": {\"name\": \"13123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:05:38');
INSERT INTO `logs` VALUES (145, 'GET_PROMOTIONS', '{\"count\": 8}', NULL, '2024-12-29 12:05:39');
INSERT INTO `logs` VALUES (146, 'GET_PROMOTIONS', '{\"count\": 8}', NULL, '2024-12-29 12:05:41');
INSERT INTO `logs` VALUES (147, 'GET_PROMOTION', '{\"id\": \"12\"}', NULL, '2024-12-29 12:05:45');
INSERT INTO `logs` VALUES (148, 'UPDATE_PROMOTION', '{\"id\": \"12\", \"updates\": {\"name\": \"13123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:05:51');
INSERT INTO `logs` VALUES (149, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 13, \"name\": \"13123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:05:51');
INSERT INTO `logs` VALUES (150, 'GET_PROMOTIONS', '{\"count\": 9}', NULL, '2024-12-29 12:05:52');
INSERT INTO `logs` VALUES (151, 'GET_PROMOTIONS', '{\"count\": 9}', NULL, '2024-12-29 12:05:54');
INSERT INTO `logs` VALUES (152, 'GET_PROMOTION', '{\"id\": \"13\"}', NULL, '2024-12-29 12:05:55');
INSERT INTO `logs` VALUES (153, 'UPDATE_PROMOTION', '{\"id\": \"13\", \"updates\": {\"name\": \"13123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:25:33');
INSERT INTO `logs` VALUES (154, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 14, \"name\": \"13123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-30\"}}', NULL, '2024-12-29 12:25:33');
INSERT INTO `logs` VALUES (155, 'GET_PROMOTIONS', '{\"count\": 10}', NULL, '2024-12-29 12:25:35');
INSERT INTO `logs` VALUES (156, 'GET_PROMOTIONS', '{\"count\": 10}', NULL, '2024-12-29 12:25:36');
INSERT INTO `logs` VALUES (157, 'GET_PROMOTIONS', '{\"count\": 10}', NULL, '2024-12-29 12:35:08');
INSERT INTO `logs` VALUES (158, 'GET_USERS', NULL, 'admin', '2024-12-29 12:35:08');
INSERT INTO `logs` VALUES (159, 'DELETE_PROMOTION', '{\"id\": \"14\"}', NULL, '2024-12-29 12:35:13');
INSERT INTO `logs` VALUES (160, 'GET_PROMOTIONS', '{\"count\": 9}', NULL, '2024-12-29 12:35:14');
INSERT INTO `logs` VALUES (161, 'DELETE_PROMOTION', '{\"id\": \"13\"}', NULL, '2024-12-29 12:35:16');
INSERT INTO `logs` VALUES (162, 'GET_PROMOTIONS', '{\"count\": 8}', NULL, '2024-12-29 12:35:17');
INSERT INTO `logs` VALUES (163, 'DELETE_PROMOTION', '{\"id\": \"12\"}', NULL, '2024-12-29 12:35:18');
INSERT INTO `logs` VALUES (164, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:35:21');
INSERT INTO `logs` VALUES (165, 'DELETE_PROMOTION', '{\"id\": \"11\"}', NULL, '2024-12-29 12:35:22');
INSERT INTO `logs` VALUES (166, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:35:23');
INSERT INTO `logs` VALUES (167, 'DELETE_PROMOTION', '{\"id\": \"10\"}', NULL, '2024-12-29 12:35:28');
INSERT INTO `logs` VALUES (168, 'GET_PROMOTIONS', '{\"count\": 5}', NULL, '2024-12-29 12:35:29');
INSERT INTO `logs` VALUES (169, 'DELETE_PROMOTION', '{\"id\": \"9\"}', NULL, '2024-12-29 12:35:30');
INSERT INTO `logs` VALUES (170, 'GET_PROMOTIONS', '{\"count\": 4}', NULL, '2024-12-29 12:35:32');
INSERT INTO `logs` VALUES (171, 'DELETE_PROMOTION', '{\"id\": \"8\"}', NULL, '2024-12-29 12:35:33');
INSERT INTO `logs` VALUES (172, 'GET_PROMOTIONS', '{\"count\": 3}', NULL, '2024-12-29 12:35:35');
INSERT INTO `logs` VALUES (173, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 15, \"name\": \"123\", \"discount\": 213, \"end_date\": \"2024-12-01\", \"start_date\": \"2024-11-25\"}}', NULL, '2024-12-29 12:35:42');
INSERT INTO `logs` VALUES (174, 'GET_PROMOTIONS', '{\"count\": 4}', NULL, '2024-12-29 12:35:44');
INSERT INTO `logs` VALUES (175, 'GET_PROMOTION', '{\"id\": \"15\"}', NULL, '2024-12-29 12:35:46');
INSERT INTO `logs` VALUES (176, 'UPDATE_PROMOTION', '{\"id\": \"15\", \"updates\": {\"name\": \"123\", \"discount\": 213, \"end_date\": \"2024-12-01\", \"start_date\": \"2024-11-25\"}}', NULL, '2024-12-29 12:35:48');
INSERT INTO `logs` VALUES (177, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 16, \"name\": \"123\", \"discount\": 213, \"end_date\": \"2024-12-01\", \"start_date\": \"2024-11-25\"}}', NULL, '2024-12-29 12:35:48');
INSERT INTO `logs` VALUES (178, 'GET_PROMOTIONS', '{\"count\": 5}', NULL, '2024-12-29 12:35:49');
INSERT INTO `logs` VALUES (179, 'GET_PROMOTIONS', '{\"count\": 5}', NULL, '2024-12-29 12:35:50');
INSERT INTO `logs` VALUES (180, 'UPDATE_PROMOTION', '{\"id\": \"15\", \"updates\": {\"name\": \"123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-29\"}}', NULL, '2024-12-29 12:36:06');
INSERT INTO `logs` VALUES (181, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 17, \"name\": \"123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-29\"}}', NULL, '2024-12-29 12:36:06');
INSERT INTO `logs` VALUES (182, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:36:07');
INSERT INTO `logs` VALUES (183, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:36:08');
INSERT INTO `logs` VALUES (184, 'GET_PROMOTION', '{\"id\": \"17\"}', NULL, '2024-12-29 12:36:22');
INSERT INTO `logs` VALUES (185, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:37:28');
INSERT INTO `logs` VALUES (186, 'GET_USERS', NULL, 'admin', '2024-12-29 12:37:28');
INSERT INTO `logs` VALUES (187, 'GET_PROMOTION', '{\"id\": \"17\"}', NULL, '2024-12-29 12:37:30');
INSERT INTO `logs` VALUES (188, 'UPDATE_PROMOTION', '{\"id\": \"17\", \"updates\": {\"name\": \"1234\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-11-29\"}}', NULL, '2024-12-29 12:37:32');
INSERT INTO `logs` VALUES (189, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:37:33');
INSERT INTO `logs` VALUES (190, 'UPDATE_PROMOTION', '{\"id\": \"17\", \"updates\": {\"name\": \"23\", \"discount\": 213, \"end_date\": \"2024-12-06\", \"start_date\": \"2024-11-29\"}}', NULL, '2024-12-29 12:37:40');
INSERT INTO `logs` VALUES (191, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:37:41');
INSERT INTO `logs` VALUES (192, 'UPDATE_PROMOTION', '{\"id\": \"17\", \"updates\": {\"name\": \"213\", \"discount\": 213, \"end_date\": \"2024-12-01\", \"start_date\": \"2024-12-07\"}}', NULL, '2024-12-29 12:37:51');
INSERT INTO `logs` VALUES (193, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:37:53');
INSERT INTO `logs` VALUES (194, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:38:38');
INSERT INTO `logs` VALUES (195, 'GET_USERS', NULL, 'admin', '2024-12-29 12:38:38');
INSERT INTO `logs` VALUES (196, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:39:53');
INSERT INTO `logs` VALUES (197, 'GET_USERS', NULL, 'admin', '2024-12-29 12:39:53');
INSERT INTO `logs` VALUES (198, 'GET_PROMOTION', '{\"id\": \"17\"}', NULL, '2024-12-29 12:39:55');
INSERT INTO `logs` VALUES (199, 'UPDATE_PROMOTION', '{\"id\": \"17\", \"updates\": {\"name\": \"213213\", \"discount\": 213, \"end_date\": \"2024-12-01\", \"start_date\": \"2024-12-07\"}}', NULL, '2024-12-29 12:39:57');
INSERT INTO `logs` VALUES (200, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:39:58');
INSERT INTO `logs` VALUES (201, 'UPDATE_PROMOTION', '{\"id\": \"17\", \"updates\": {\"name\": \"123\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:40:05');
INSERT INTO `logs` VALUES (202, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:40:07');
INSERT INTO `logs` VALUES (203, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:50:16');
INSERT INTO `logs` VALUES (204, 'GET_USERS', NULL, 'admin', '2024-12-29 12:50:16');
INSERT INTO `logs` VALUES (205, 'UPDATE_MOVIE', '{\"movieId\": \"1\", \"newData\": {\"genre\": \"2\", \"price\": 16, \"title\": \"The Dark Knight\", \"rating\": 1, \"director\": \"Christopher Nolan\", \"duration\": 21, \"image_url\": \"images/The Dark Knight.jpg\", \"description\": \"When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.\", \"release_year\": 2008}, \"oldData\": {\"id\": 1, \"image\": \"images/The Dark Knight.jpg\", \"price\": \"16.00\", \"title\": \"The Dark Knight\", \"rating\": \"1\", \"type_id\": 1, \"director\": \"Christopher Nolan\", \"duration\": \"2\", \"show_time\": \"2024-12-29T03:20:36.000Z\", \"created_at\": \"2024-12-28T13:32:26.000Z\", \"updated_at\": \"2024-12-29T00:18:10.000Z\", \"description\": \"When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.\", \"releaseYear\": 2008}, \"updatedAt\": \"2024-12-29T12:51:42.849Z\", \"movieTitle\": \"The Dark Knight\"}', 'system', '2024-12-29 12:51:42');
INSERT INTO `logs` VALUES (206, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 12:52:01');
INSERT INTO `logs` VALUES (207, 'GET_USERS', NULL, 'admin', '2024-12-29 12:52:01');
INSERT INTO `logs` VALUES (208, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 18, \"name\": \"13\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:10');
INSERT INTO `logs` VALUES (209, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:12');
INSERT INTO `logs` VALUES (210, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 12:52:13');
INSERT INTO `logs` VALUES (211, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:14');
INSERT INTO `logs` VALUES (212, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:14');
INSERT INTO `logs` VALUES (213, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:16');
INSERT INTO `logs` VALUES (214, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:17');
INSERT INTO `logs` VALUES (215, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 12:52:18');
INSERT INTO `logs` VALUES (216, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"13333\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:21');
INSERT INTO `logs` VALUES (217, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"13333\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:21');
INSERT INTO `logs` VALUES (218, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:22');
INSERT INTO `logs` VALUES (219, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:24');
INSERT INTO `logs` VALUES (220, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 12:52:26');
INSERT INTO `logs` VALUES (221, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:28');
INSERT INTO `logs` VALUES (222, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:28');
INSERT INTO `logs` VALUES (223, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:29');
INSERT INTO `logs` VALUES (224, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:31');
INSERT INTO `logs` VALUES (225, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 12:52:35');
INSERT INTO `logs` VALUES (226, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"1333333\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:36');
INSERT INTO `logs` VALUES (227, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"1333333\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 12:52:36');
INSERT INTO `logs` VALUES (228, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:37');
INSERT INTO `logs` VALUES (229, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 12:52:38');
INSERT INTO `logs` VALUES (230, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 13:04:04');
INSERT INTO `logs` VALUES (231, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"13333334\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:04:05');
INSERT INTO `logs` VALUES (232, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"13333334\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:04:05');
INSERT INTO `logs` VALUES (233, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:04:06');
INSERT INTO `logs` VALUES (234, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:04:20');
INSERT INTO `logs` VALUES (235, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 13:04:22');
INSERT INTO `logs` VALUES (236, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333345\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:04:24');
INSERT INTO `logs` VALUES (237, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333345\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:04:24');
INSERT INTO `logs` VALUES (238, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:04:25');
INSERT INTO `logs` VALUES (239, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:04:25');
INSERT INTO `logs` VALUES (240, 'GET_USERS', NULL, 'admin', '2024-12-29 13:05:05');
INSERT INTO `logs` VALUES (241, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:05:05');
INSERT INTO `logs` VALUES (242, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 13:05:07');
INSERT INTO `logs` VALUES (243, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"1333333454\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:05:09');
INSERT INTO `logs` VALUES (244, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"1333333454\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:05:09');
INSERT INTO `logs` VALUES (245, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:05:10');
INSERT INTO `logs` VALUES (246, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:05:13');
INSERT INTO `logs` VALUES (247, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:05:24');
INSERT INTO `logs` VALUES (248, 'GET_USERS', NULL, 'admin', '2024-12-29 13:05:24');
INSERT INTO `logs` VALUES (249, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 13:05:25');
INSERT INTO `logs` VALUES (250, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"13333334544\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:05:26');
INSERT INTO `logs` VALUES (251, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"13333334544\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:05:26');
INSERT INTO `logs` VALUES (252, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:05:27');
INSERT INTO `logs` VALUES (253, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:05:36');
INSERT INTO `logs` VALUES (254, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:30:06');
INSERT INTO `logs` VALUES (255, 'GET_USERS', NULL, 'admin', '2024-12-29 13:30:06');
INSERT INTO `logs` VALUES (256, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 13:30:08');
INSERT INTO `logs` VALUES (257, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333345444\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:30:10');
INSERT INTO `logs` VALUES (258, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333345444\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:30:10');
INSERT INTO `logs` VALUES (259, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:30:11');
INSERT INTO `logs` VALUES (260, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:30:12');
INSERT INTO `logs` VALUES (261, 'GET_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 13:30:16');
INSERT INTO `logs` VALUES (262, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333345444\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:30:17');
INSERT INTO `logs` VALUES (263, 'UPDATE_PROMOTION', '{\"id\": \"18\", \"updates\": {\"name\": \"133333345444\", \"discount\": 123, \"end_date\": \"2024-12-11\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:30:17');
INSERT INTO `logs` VALUES (264, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:30:19');
INSERT INTO `logs` VALUES (265, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:30:24');
INSERT INTO `logs` VALUES (266, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:31:29');
INSERT INTO `logs` VALUES (267, 'GET_USERS', NULL, 'admin', '2024-12-29 13:31:29');
INSERT INTO `logs` VALUES (268, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:31:35');
INSERT INTO `logs` VALUES (269, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:31:43');
INSERT INTO `logs` VALUES (270, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:31:52');
INSERT INTO `logs` VALUES (271, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:51:11');
INSERT INTO `logs` VALUES (272, 'GET_USERS', NULL, 'admin', '2024-12-29 13:51:11');
INSERT INTO `logs` VALUES (273, 'DELETE_PROMOTION', '{\"id\": \"18\"}', NULL, '2024-12-29 13:51:35');
INSERT INTO `logs` VALUES (274, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 13:51:36');
INSERT INTO `logs` VALUES (275, 'GET_PROMOTION', '{\"id\": \"17\"}', NULL, '2024-12-29 13:51:40');
INSERT INTO `logs` VALUES (276, 'UPDATE_PROMOTION', '{\"id\": \"17\", \"updates\": {\"name\": \"1234\", \"discount\": 123, \"end_date\": \"2024-11-29\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:51:41');
INSERT INTO `logs` VALUES (277, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 13:51:42');
INSERT INTO `logs` VALUES (278, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 19, \"name\": \"123\", \"discount\": 123, \"end_date\": \"2024-12-12\", \"start_date\": \"2024-12-06\"}}', NULL, '2024-12-29 13:51:51');
INSERT INTO `logs` VALUES (279, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:51:52');
INSERT INTO `logs` VALUES (280, 'GET_PROMOTION', '{\"id\": \"19\"}', NULL, '2024-12-29 13:51:54');
INSERT INTO `logs` VALUES (281, 'UPDATE_PROMOTION', '{\"id\": \"19\", \"updates\": {\"name\": \"12344\", \"discount\": 123, \"end_date\": \"2024-12-12\", \"start_date\": \"2024-12-06\"}}', NULL, '2024-12-29 13:51:57');
INSERT INTO `logs` VALUES (282, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:51:58');
INSERT INTO `logs` VALUES (283, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 20, \"name\": \"3333\", \"discount\": 3, \"end_date\": \"2024-12-10\", \"start_date\": \"2024-12-12\"}}', NULL, '2024-12-29 13:52:06');
INSERT INTO `logs` VALUES (284, 'GET_PROMOTIONS', '{\"count\": 8}', NULL, '2024-12-29 13:52:07');
INSERT INTO `logs` VALUES (285, 'DELETE_PROMOTION', '{\"id\": \"20\"}', NULL, '2024-12-29 13:52:11');
INSERT INTO `logs` VALUES (286, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 13:52:12');
INSERT INTO `logs` VALUES (287, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 14:00:17');
INSERT INTO `logs` VALUES (288, 'GET_USERS', NULL, 'admin', '2024-12-29 14:00:17');
INSERT INTO `logs` VALUES (289, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 14:02:24');
INSERT INTO `logs` VALUES (290, 'GET_USERS', NULL, 'admin', '2024-12-29 14:02:24');
INSERT INTO `logs` VALUES (291, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 14:27:32');
INSERT INTO `logs` VALUES (292, 'GET_USERS', NULL, 'admin', '2024-12-29 14:27:32');
INSERT INTO `logs` VALUES (293, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 14:38:24');
INSERT INTO `logs` VALUES (294, 'GET_USERS', NULL, 'admin', '2024-12-29 14:38:24');
INSERT INTO `logs` VALUES (295, 'GET_PROMOTION', '{\"id\": \"19\"}', NULL, '2024-12-29 14:40:05');
INSERT INTO `logs` VALUES (296, 'UPDATE_PROMOTION', '{\"id\": \"19\", \"updates\": {\"name\": \"1234444\", \"discount\": 123, \"end_date\": \"2024-12-12\", \"start_date\": \"2024-12-06\"}}', NULL, '2024-12-29 14:40:07');
INSERT INTO `logs` VALUES (297, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 14:40:08');
INSERT INTO `logs` VALUES (298, 'ADD_PROMOTION', '{\"promotion\": {\"id\": 21, \"name\": \"213\", \"discount\": 123, \"end_date\": \"2024-12-18\", \"start_date\": \"2024-11-28\"}}', NULL, '2024-12-29 14:40:16');
INSERT INTO `logs` VALUES (299, 'GET_PROMOTIONS', '{\"count\": 8}', NULL, '2024-12-29 14:40:17');
INSERT INTO `logs` VALUES (300, 'GET_PROMOTIONS', '{\"count\": 8}', NULL, '2024-12-29 14:40:40');
INSERT INTO `logs` VALUES (301, 'GET_USERS', NULL, 'admin', '2024-12-29 14:40:40');
INSERT INTO `logs` VALUES (302, 'GET_PROMOTIONS', '{\"count\": 8}', NULL, '2024-12-29 14:44:36');
INSERT INTO `logs` VALUES (303, 'GET_USERS', NULL, 'admin', '2024-12-29 14:44:36');
INSERT INTO `logs` VALUES (304, 'USER_LOGIN', '{\"userId\": 6, \"username\": \"123\", \"loginTime\": \"2024-12-29T14:45:01.355Z\"}', '123', '2024-12-29 14:45:01');
INSERT INTO `logs` VALUES (305, 'CREATE_BOOKING', '{\"userId\": 6, \"movieId\": 1, \"userName\": null, \"bookingId\": 12, \"createdAt\": \"2024-12-29T14:45:16.148Z\", \"movieTitle\": \"The Dark Knight\", \"totalPrice\": 32, \"seatNumbers\": [\"2-7\", \"2-6\"]}', NULL, '2024-12-29 14:45:16');
INSERT INTO `logs` VALUES (306, 'DELETE_PROMOTION', '{\"id\": \"21\"}', NULL, '2024-12-29 14:45:34');
INSERT INTO `logs` VALUES (307, 'GET_PROMOTIONS', '{\"count\": 7}', NULL, '2024-12-29 14:45:35');
INSERT INTO `logs` VALUES (308, 'DELETE_PROMOTION', '{\"id\": \"19\"}', NULL, '2024-12-29 14:45:37');
INSERT INTO `logs` VALUES (309, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 14:45:37');
INSERT INTO `logs` VALUES (310, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 14:52:06');
INSERT INTO `logs` VALUES (311, 'GET_USERS', NULL, 'admin', '2024-12-29 14:52:06');
INSERT INTO `logs` VALUES (312, 'UPDATE_MOVIE', '{\"movieId\": \"1\", \"newData\": {\"price\": \"16.00\", \"title\": \"The Dark Knight\", \"rating\": \"1\", \"type_id\": \"1\", \"director\": \"Christopher Nolan\", \"duration\": \"21\", \"image_url\": \"\", \"description\": \"When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.\", \"release_year\": \"123\"}, \"oldData\": {\"id\": 1, \"image\": \"images/The Dark Knight.jpg\", \"price\": \"16.00\", \"title\": \"The Dark Knight\", \"rating\": \"1\", \"type_id\": 1, \"director\": \"Christopher Nolan\", \"duration\": \"21\", \"show_time\": \"2024-12-29T03:20:36.000Z\", \"created_at\": \"2024-12-28T13:32:26.000Z\", \"updated_at\": \"2024-12-29T05:53:49.000Z\", \"description\": \"When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.\", \"releaseYear\": 2008}, \"updatedAt\": \"2024-12-29T14:52:15.163Z\", \"movieTitle\": \"The Dark Knight\"}', 'system', '2024-12-29 14:52:15');
INSERT INTO `logs` VALUES (313, 'GET_USERS', NULL, 'admin', '2024-12-29 15:03:44');
INSERT INTO `logs` VALUES (314, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-29 15:03:44');
INSERT INTO `logs` VALUES (315, 'GET_USERS', NULL, 'admin', '2024-12-31 08:53:27');
INSERT INTO `logs` VALUES (316, 'GET_PROMOTIONS', '{\"count\": 6}', NULL, '2024-12-31 08:53:27');
INSERT INTO `logs` VALUES (317, 'ADD_MOVIE', '{\"movieId\": 7, \"createdAt\": \"2024-12-31T08:53:36.335Z\", \"movieTitle\": \"123\", \"movieDetails\": {\"price\": \"123\", \"title\": \"123\", \"rating\": \"123\", \"type_id\": \"8\", \"director\": \"123\", \"duration\": \"123\", \"image_url\": \"123\", \"description\": \"123\", \"release_year\": \"123\"}}', 'system', '2024-12-31 08:53:36');
INSERT INTO `logs` VALUES (318, 'USER_LOGIN', '{\"userId\": 6, \"username\": \"123\", \"loginTime\": \"2024-12-31T08:53:45.533Z\"}', '123', '2024-12-31 08:53:45');
INSERT INTO `logs` VALUES (319, 'DELETE_MOVIE', '{\"movieId\": \"7\", \"deletedAt\": \"2024-12-31T08:58:32.055Z\", \"movieTitle\": \"123\"}', 'system', '2024-12-31 08:58:32');

-- ----------------------------
-- Table structure for movie_cast
-- ----------------------------
DROP TABLE IF EXISTS `movie_cast`;
CREATE TABLE `movie_cast`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `cast_member` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_cast
-- ----------------------------
INSERT INTO `movie_cast` VALUES (1, 1, 'Christian Bale as Bruce Wayne/Batman');
INSERT INTO `movie_cast` VALUES (2, 1, 'Heath Ledger as The Joker');
INSERT INTO `movie_cast` VALUES (3, 1, 'Aaron Eckhart as Harvey Dent');
INSERT INTO `movie_cast` VALUES (4, 1, 'Michael Caine as Alfred');
INSERT INTO `movie_cast` VALUES (5, 1, 'Gary Oldman as Jim Gordon');

-- ----------------------------
-- Table structure for movie_highlights
-- ----------------------------
DROP TABLE IF EXISTS `movie_highlights`;
CREATE TABLE `movie_highlights`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `highlight` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `movie_highlights_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_highlights
-- ----------------------------
INSERT INTO `movie_highlights` VALUES (1, 1, 'Heath Ledger\'s legendary Joker performance');
INSERT INTO `movie_highlights` VALUES (2, 1, 'Complex moral themes');
INSERT INTO `movie_highlights` VALUES (3, 1, 'Revolutionary IMAX sequences');
INSERT INTO `movie_highlights` VALUES (4, 1, 'Oscar-winning achievements');

-- ----------------------------
-- Table structure for movie_reviews
-- ----------------------------
DROP TABLE IF EXISTS `movie_reviews`;
CREATE TABLE `movie_reviews`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `imdb` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rottenTomatoes` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `movie_reviews_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_reviews
-- ----------------------------
INSERT INTO `movie_reviews` VALUES (1, 1, '9.0/10', '94%');

-- ----------------------------
-- Table structure for movie_tickets
-- ----------------------------
DROP TABLE IF EXISTS `movie_tickets`;
CREATE TABLE `movie_tickets`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `user_id` int NOT NULL,
  `seat_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `paid_price` decimal(10, 2) NOT NULL,
  `purchase_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','paid','used','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending',
  `payment_method` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_seat_screening`(`movie_id`, `seat_number`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `movie_tickets_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `movie_tickets_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_tickets
-- ----------------------------
INSERT INTO `movie_tickets` VALUES (11, 1, 6, '[\"2-7\",\"2-5\"]', 32.00, '2024-12-29 11:33:20', 'pending', 'card');
INSERT INTO `movie_tickets` VALUES (12, 1, 6, '[\"2-7\",\"2-6\"]', 32.00, '2024-12-29 14:45:16', 'pending', 'google');

-- ----------------------------
-- Table structure for movie_types
-- ----------------------------
DROP TABLE IF EXISTS `movie_types`;
CREATE TABLE `movie_types`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `director` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `duration` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `releaseYear` int NOT NULL,
  `rating` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `show_time` datetime NULL DEFAULT NULL,
  `type_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movies
-- ----------------------------
INSERT INTO `movies` VALUES (1, 'The Dark Knight', 'Christopher Nolan', '21', 16.00, 123, '1', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', '213', '2024-12-28 21:32:26', '2024-12-29 15:28:22', '2024-12-29 11:20:36', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of promotions
-- ----------------------------
INSERT INTO `promotions` VALUES (2, '123', 21.00, '2024-12-05', '2024-12-14', '2024-12-22 13:04:10', '2024-12-22 13:04:10');
INSERT INTO `promotions` VALUES (4, '21333', 1.00, '2024-11-30', '2024-12-07', '2024-12-22 13:42:50', '2024-12-29 11:55:29');
INSERT INTO `promotions` VALUES (7, '2133344', 1.00, '2024-11-30', '2024-12-07', '2024-12-29 11:55:29', '2024-12-29 11:55:37');
INSERT INTO `promotions` VALUES (15, '123', 123.00, '2024-11-29', '2024-11-29', '2024-12-29 12:35:42', '2024-12-29 12:36:06');
INSERT INTO `promotions` VALUES (16, '123', 213.00, '2024-11-25', '2024-12-01', '2024-12-29 12:35:48', '2024-12-29 12:35:48');
INSERT INTO `promotions` VALUES (17, '1234', 123.00, '2024-12-12', '2024-11-29', '2024-12-29 12:36:06', '2024-12-29 13:51:41');

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (5, 'user23', 'user2', 'user2@qq.com', '2024-12-22 11:53:50');
INSERT INTO `users` VALUES (6, '123', '123', '123@qq.com', '2024-12-28 21:03:48');

SET FOREIGN_KEY_CHECKS = 1;
