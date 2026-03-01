/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80035 (8.0.35)
 Source Host           : localhost:3306
 Source Schema         : tcr_system

 Target Server Type    : MySQL
 Target Server Version : 80035 (8.0.35)
 File Encoding         : 65001

 Date: 20/03/2025 16:42:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for assignment
-- ----------------------------
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '作业ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作业标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '作业描述',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `teacher_id` bigint NOT NULL COMMENT '发布教师ID',
  `deadline` datetime NOT NULL COMMENT '截止日期',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-已关闭，1-进行中，2-已结束',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_course_id`(`course_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '作业表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of assignment
-- ----------------------------
INSERT INTO `assignment` VALUES (5, '描述一下这门课程Java程序设计', '描述一下这门课程Java程序设计', 1, 2, '2025-04-05 00:00:00', 1, 0, '2025-03-15 11:20:05', '2025-03-15 11:20:05');
INSERT INTO `assignment` VALUES (6, '111111', '111111', 1, 2, '2025-04-04 16:00:00', 1, 0, '2025-03-15 12:53:36', '2025-03-15 12:53:36');
INSERT INTO `assignment` VALUES (7, '222222', '22222', 1, 2, '2025-03-28 16:00:00', 1, 0, '2025-03-15 12:55:09', '2025-03-15 12:55:09');
INSERT INTO `assignment` VALUES (8, '描述一下数据库管理这门课', '描述一下数据库管理这门课', 2, 2, '2025-03-27 16:00:00', 1, 0, '2025-03-17 17:42:34', '2025-03-17 17:42:34');
INSERT INTO `assignment` VALUES (9, '描述一下数据库管理这门课2', '描述一下数据库管理这门课2', 2, 2, '2025-04-04 16:00:00', 1, 0, '2025-03-17 17:55:27', '2025-03-17 17:55:27');
INSERT INTO `assignment` VALUES (10, '12312313', 'awdawdawd', 1, 2, '2025-04-05 10:04:11', 1, 0, '2025-03-17 18:04:16', '2025-03-17 18:04:16');
INSERT INTO `assignment` VALUES (11, '99999929', '123131131', 1, 2, '2025-04-04 16:00:00', 1, 0, '2025-03-17 18:05:29', '2025-03-17 18:05:29');

-- ----------------------------
-- Table structure for assignment_submission
-- ----------------------------
DROP TABLE IF EXISTS `assignment_submission`;
CREATE TABLE `assignment_submission`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '提交ID',
  `assignment_id` bigint NOT NULL COMMENT '作业ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '提交内容',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `file_size` bigint NULL DEFAULT NULL COMMENT '文件大小(字节)',
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `score` int NULL DEFAULT NULL COMMENT '得分',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '教师评语',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-已提交，1-已批改',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_assignment_student`(`assignment_id` ASC, `student_id` ASC) USING BTREE,
  INDEX `idx_assignment_id`(`assignment_id` ASC) USING BTREE,
  INDEX `idx_student_id`(`student_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生作业提交表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of assignment_submission
-- ----------------------------
INSERT INTO `assignment_submission` VALUES (7, 5, 4, '111', NULL, NULL, NULL, 91, '', 1, 0, '2025-03-15 11:52:35', '2025-03-15 12:28:22');
INSERT INTO `assignment_submission` VALUES (10, 7, 4, '1111111111111111111111', 'assignments/4/5ef88b12-bb94-43fb-b885-47ba77f174ba.doc', 85480, 'application/msword', 100, '', 1, 0, '2025-03-15 15:37:25', '2025-03-15 15:37:25');
INSERT INTO `assignment_submission` VALUES (11, 6, 4, '11111', 'assignments/4/bcec97b4-1af1-47e0-b41e-5ee47eaf903b.xlsx', 9199, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 0, 0, '2025-03-15 16:01:42', '2025-03-15 16:01:42');
INSERT INTO `assignment_submission` VALUES (12, 8, 4, '数据库管理这门课很好', 'assignments/4/5cef4f18-2304-41ab-a3de-d83b586024a4.pdf', 44074, 'application/pdf', NULL, NULL, 0, 0, '2025-03-17 17:53:48', '2025-03-17 17:53:48');
INSERT INTO `assignment_submission` VALUES (13, 9, 4, '作业内容', 'assignments/4/39a289cb-6dd5-4d5e-97c2-7e03a67a0602.jpg', 28314, 'image/jpeg', NULL, NULL, 0, 0, '2025-03-17 17:55:52', '2025-03-17 17:55:52');
INSERT INTO `assignment_submission` VALUES (14, 10, 4, '111111', 'assignments/4/98844f41-77b8-4b10-ad9c-49327426f172.xlsx', 9199, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 0, 0, '2025-03-17 18:04:45', '2025-03-17 18:04:45');
INSERT INTO `assignment_submission` VALUES (15, 11, 4, '123123123', 'assignments/4/e4a4af3c-13ed-497a-a69b-e2b74160528c.xlsx', 9199, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 0, 0, '2025-03-17 18:08:29', '2025-03-17 18:08:29');

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '班级ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班级名称',
  `major_id` bigint NOT NULL COMMENT '所属专业ID',
  `year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入学年份',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '班级描述',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_major_id`(`major_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '班级表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES (1, '计算机科学与技术2022级1班', 1, '2022', '计算机科学与技术专业2022级1班', 0, '2025-03-15 17:30:42', '2025-03-15 17:30:42');
INSERT INTO `class` VALUES (2, '软件工程2022级1班', 2, '2022', '软件工程专业2022级1班', 0, '2025-03-15 17:30:42', '2025-03-15 17:30:42');
INSERT INTO `class` VALUES (3, '数据科学与大数据技术2022级1班', 3, '2022', '数据科学与大数据技术专业2022级1班', 0, '2025-03-15 17:30:42', '2025-03-15 17:30:42');

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '学院ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学院名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '学院描述',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学院表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES (1, '计算机学院', '计算机科学与技术学院', 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `college` VALUES (2, '数学学院', '数学与统计学院', 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `college` VALUES (3, '外国语学院', '外国语言文学学院', 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '课程描述',
  `teacher_id` bigint NOT NULL COMMENT '教师ID',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '课程封面',
  `class_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上课时间',
  `class_location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上课地点',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结课时间',
  `end_form` tinyint NULL DEFAULT 0 COMMENT '结课形式：0-考试，1-大作业',
  `end_location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结课地点（考试地点）',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-未开始，1-进行中，2-已结束',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'Java程序设计', 'Java编程基础课程，包括基础语法、面向对象、集合框架等内容', 2, NULL, '周一 8:00-9:40', '教学楼A-101', '2025-06-30 01:00:00', 0, '教学楼C-203', 1, 0, '2025-03-06 16:38:00', '2025-03-19 12:00:45');
INSERT INTO `course` VALUES (2, '数据库原理', '数据库基础课程，包括SQL语言、数据库设计、事务管理等内容', 2, NULL, '周二 10:00-11:40', '教学楼B-302', '2025-07-02 14:00:00', 0, '教学楼C-201', 1, 0, '2025-03-06 16:38:00', '2025-03-13 19:11:30');
INSERT INTO `course` VALUES (3, 'Web开发技术', 'Web开发基础课程，包括HTML、CSS、JavaScript等内容', 3, NULL, '周三 14:00-15:40', '教学楼A-201', '2025-06-30 00:00:00', 1, NULL, 1, 0, '2025-03-06 16:38:00', '2025-03-13 19:11:30');
INSERT INTO `course` VALUES (4, '软件工程', '软件工程课程，包括软件开发流程、项目管理、质量保证等内容', 3, NULL, '周四 16:00-17:40', '教学楼B-201', '2025-07-04 17:00:00', 0, '教学楼C-301', 0, 0, '2025-03-06 16:38:00', '2025-03-17 16:01:23');
INSERT INTO `course` VALUES (5, 'JAVAEE', '张老师带你添砖JAVA', 3, NULL, '周二9:00-12:00', '教学楼C303', '2025-03-19 00:00:00', 0, '教学楼C203', 1, 0, '2025-03-18 12:44:43', '2025-03-19 12:12:38');
INSERT INTO `course` VALUES (7, 'Java程序设计', '杨老师带你精通Java', 12, NULL, '周五9:00-19:00', '实训楼B323', '2025-04-04 16:00:00', 1, '', 1, 0, '2025-03-19 12:36:55', '2025-03-19 12:36:55');

-- ----------------------------
-- Table structure for course_major
-- ----------------------------
DROP TABLE IF EXISTS `course_major`;
CREATE TABLE `course_major`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `major_id` bigint NOT NULL COMMENT '专业ID',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_course_major`(`course_id` ASC, `major_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程专业关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course_major
-- ----------------------------
INSERT INTO `course_major` VALUES (1, 1, 1, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (2, 1, 2, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (3, 2, 1, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (4, 2, 2, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (5, 2, 3, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (6, 3, 2, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (7, 4, 1, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (8, 4, 2, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `course_major` VALUES (9, 5, 1, 0, '2025-03-19 12:12:38', '2025-03-19 12:12:38');
INSERT INTO `course_major` VALUES (10, 7, 1, 0, '2025-03-19 12:36:55', '2025-03-19 12:36:55');
INSERT INTO `course_major` VALUES (11, 7, 2, 0, '2025-03-19 12:36:55', '2025-03-19 12:36:55');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '反馈ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '反馈内容',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父反馈ID，用于回复',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '反馈表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, '课程内容很充实，讲解也很清晰', 1, 4, NULL, 0, '2025-03-06 16:38:00', '2025-03-06 16:38:00');
INSERT INTO `feedback` VALUES (2, '谢谢同学的认可，我们会继续努力', 1, 2, 1, 0, '2025-03-06 16:38:00', '2025-03-06 16:38:00');
INSERT INTO `feedback` VALUES (3, '实验环境搭建遇到了一些问题，希望能提供更详细的指导', 2, 5, NULL, 0, '2025-03-06 16:38:00', '2025-03-06 16:38:00');
INSERT INTO `feedback` VALUES (4, '已经更新了实验指导文档，请查收', 2, 2, 3, 0, '2025-03-06 16:38:00', '2025-03-06 16:38:00');
INSERT INTO `feedback` VALUES (5, '示例代码对理解知识点很有帮助', 3, 6, NULL, 0, '2025-03-06 16:38:00', '2025-03-06 16:38:00');
INSERT INTO `feedback` VALUES (6, '好的', 1, 10, 1, 0, '2025-03-11 09:22:00', '2025-03-11 09:22:00');
INSERT INTO `feedback` VALUES (7, '55555555555', 1, 4, NULL, 0, '2025-03-12 09:07:23', '2025-03-12 09:07:23');
INSERT INTO `feedback` VALUES (8, '12145', 1, 4, 7, 1, '2025-03-12 09:07:28', '2025-03-14 08:13:00');
INSERT INTO `feedback` VALUES (9, '222222', 1, 4, 7, 0, '2025-03-14 08:13:06', '2025-03-14 08:13:06');
INSERT INTO `feedback` VALUES (10, '1', 1, 2, 1, 1, '2025-03-15 16:53:33', '2025-03-15 16:58:53');
INSERT INTO `feedback` VALUES (11, '同学们感觉课程如何', 1, 2, NULL, 0, '2025-03-15 16:58:12', '2025-03-15 16:58:12');
INSERT INTO `feedback` VALUES (12, '感觉如何', 1, 2, 11, 0, '2025-03-15 16:58:18', '2025-03-15 16:58:18');
INSERT INTO `feedback` VALUES (13, '非常好', 1, 4, 11, 0, '2025-03-15 16:58:37', '2025-03-15 16:58:37');
INSERT INTO `feedback` VALUES (14, '1111', 1, 2, 11, 0, '2025-03-17 18:19:44', '2025-03-17 18:19:44');
INSERT INTO `feedback` VALUES (15, '1111', 1, 2, NULL, 0, '2025-03-17 18:19:46', '2025-03-17 18:19:46');
INSERT INTO `feedback` VALUES (16, '1', 1, 4, 15, 0, '2025-03-18 09:22:55', '2025-03-18 09:22:55');
INSERT INTO `feedback` VALUES (17, '22222', 1, 4, NULL, 1, '2025-03-18 09:22:59', '2025-03-18 09:23:04');

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '专业ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专业名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '专业描述',
  `college_id` bigint NOT NULL COMMENT '所属学院ID',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '专业表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES (1, '计算机科学与技术', '计算机科学与技术专业', 1, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `major` VALUES (2, '软件工程', '软件工程专业', 1, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `major` VALUES (3, '数据科学与大数据技术', '数据科学与大数据技术专业', 1, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `major` VALUES (4, '数学与应用数学', '数学与应用数学专业', 2, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `major` VALUES (5, '统计学', '统计学专业', 2, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `major` VALUES (6, '英语', '英语专业', 3, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `major` VALUES (7, '日语', '日语专业', 3, 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '材料ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '材料名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '材料描述',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `file_size` bigint NOT NULL COMMENT '文件大小(字节)',
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `upload_user_id` bigint NOT NULL COMMENT '上传用户ID',
  `download_count` int NOT NULL DEFAULT 0 COMMENT '下载次数',
  `type` tinyint NOT NULL DEFAULT 0 COMMENT '材料类型：0-课程材料，1-学生资料',
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学年',
  `semester` tinyint NULL DEFAULT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `material_type_id` bigint NULL DEFAULT NULL COMMENT '材料类型ID',
  `task_id` bigint NULL DEFAULT NULL COMMENT '关联的任务ID',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_task_id`(`task_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教学材料表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES (18, '2025-2026Java教学大纲', '2025-2026Java教学大纲', 1, '2025/03/3279842e-34a0-4437-9874-1d12b3f4aa66.doc', 85480, 'doc', 2, 8, 0, '2025-2026', 1, 1, NULL, 0, '2025-03-15 22:13:56', '2025-03-15 22:13:56');
INSERT INTO `material` VALUES (20, '2024-2025学年第一学期教学大纲上传', '2024-2025学年第一学期教学大纲上传', 1, '2025/03/fb31c3fa-17d6-473d-95c4-c7d03fd5cd20.doc', 85480, 'doc', 2, 11, 0, '2024-2025', 1, 1, NULL, 0, '2025-03-16 13:10:38', '2025-03-19 13:40:00');
INSERT INTO `material` VALUES (21, '2024-2025第一学期java教学大纲', '2024-2025第一学期java教学大纲', 1, '2025/03/a685e6a0-6143-4b76-8663-2ecc61ca648e.doc', 85480, 'doc', 2, 11, 0, '2024-2025', 1, 1, 5, 0, '2025-03-16 14:31:31', '2025-03-19 13:32:47');
INSERT INTO `material` VALUES (24, '11111', '111111', 1, '2025/03/d9b6a4ba-73d7-4be1-971d-94888932ac72.doc', 85480, 'doc', 2, 2, 0, '2025-2026', 1, 4, NULL, 0, '2025-03-16 15:25:30', '2025-03-16 15:25:30');
INSERT INTO `material` VALUES (25, '2222', '2222', 1, '2025/03/fc3b06c8-896a-4d2b-ab7e-2c29955fd488.doc', 85480, 'doc', 2, 15, 0, '2025-2026', 1, 1, NULL, 0, '2025-03-17 18:24:41', '2025-03-19 13:37:48');
INSERT INTO `material` VALUES (26, '66666', '6666', 1, '2025/03/3f416dbe-d4c8-4589-a744-997a2e3f8eed.doc', 85480, 'doc', 2, 1, 0, '2025-2026', 1, 4, 5, 0, '2025-03-16 15:57:58', '2025-03-16 15:57:58');
INSERT INTO `material` VALUES (27, '888888', '88888', 1, '2025/03/87ab087c-c124-46e5-b2f3-739c21564c25.doc', 85480, 'doc', 2, 2, 0, '2025-2026', 1, 4, 5, 0, '2025-03-16 16:28:53', '2025-03-16 16:28:53');
INSERT INTO `material` VALUES (28, '999999', '99999999', 1, '2025/03/84e00899-e4e9-4063-a3d5-db32cc46c8b7.doc', 85480, 'doc', 2, 4, 0, '2025-2026', 1, 4, 5, 0, '2025-03-16 16:37:08', '2025-03-16 16:37:08');
INSERT INTO `material` VALUES (29, '2024-2025学年第一学期Java教学大纲', '2024-2025学年第一学期Java教学大纲', 1, '2025/03/8d4f9311-60a9-4c7c-a3fe-152b3b2508c8.doc', 85480, 'doc', 2, 18, 0, '2024-2025', 1, 1, 4, 0, '2025-03-17 10:34:00', '2025-03-19 13:39:56');
INSERT INTO `material` VALUES (30, '097867578', '11111', 1, '2025/03/8aa10dcd-855b-435c-912a-47712858358a.xlsx', 9199, 'xlsx', 2, 23, 0, '2025-2026', 1, 1, NULL, 0, '2025-03-18 09:15:40', '2025-03-19 13:36:52');
INSERT INTO `material` VALUES (32, '1111', '1111', 1, '2025/03/b37228b5-c044-403b-9e4e-3a4233a0a08c.xlsx', 9199, 'xlsx', 2, 6, 0, '2021-2022', 1, 4, NULL, 0, '2025-03-18 11:47:20', '2025-03-18 11:47:20');
INSERT INTO `material` VALUES (41, '2025-2026学年第一学期javaEE教学大纲', '2025-2026学年第一学期javaEE教学大纲', 5, '2025/03/37c60cde-663d-4e41-8975-c76bd3aa427d.xlsx', 9199, 'xlsx', 3, 5, 0, '2025-2026', 1, 1, 1, 0, '2025-03-19 12:19:26', '2025-03-19 12:19:26');
INSERT INTO `material` VALUES (43, '2025-2026Java程序设计授课计划', '2025-2026Java程序设计授课计划', 1, '2025/03/fd4a9b55-c24f-42cf-b9ae-487624767474.doc', 85480, 'doc', 2, 5, 0, '2025-2026', 1, 2, NULL, 0, '2025-03-19 13:34:43', '2025-03-19 13:36:39');
INSERT INTO `material` VALUES (44, '2024-2025学年Java程序设计授课计划', '2024-2025学年Java程序设计授课计划', 1, '2025/03/768c672a-d813-4fd4-a66f-7a51a75f7ac7.xlsx', 9199, 'xlsx', 2, 6, 0, '2024-2025', 1, 2, NULL, 0, '2025-03-19 13:36:18', '2025-03-19 13:40:09');

-- ----------------------------
-- Table structure for material_review
-- ----------------------------
DROP TABLE IF EXISTS `material_review`;
CREATE TABLE `material_review`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '审核ID',
  `material_id` bigint NOT NULL COMMENT '材料ID',
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学年',
  `semester` tinyint NOT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `material_type_id` bigint NOT NULL COMMENT '材料类型ID',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-待审核，1-课程负责人审核中，2-专业负责人审核中，3-副院长审核中，4-教务人员审核中，5-审核通过，6-审核不通过',
  `current_reviewer_id` bigint NULL DEFAULT NULL COMMENT '当前审核人ID',
  `submit_user_id` bigint NOT NULL COMMENT '提交用户ID',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `major_id` bigint NOT NULL COMMENT '所属专业ID',
  `college_id` bigint NOT NULL COMMENT '所属学院ID',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_material_id`(`material_id` ASC) USING BTREE,
  INDEX `idx_course_id`(`course_id` ASC) USING BTREE,
  INDEX `idx_submit_user_id`(`submit_user_id` ASC) USING BTREE,
  INDEX `idx_current_reviewer_id`(`current_reviewer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教学材料审核表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material_review
-- ----------------------------
INSERT INTO `material_review` VALUES (29, 18, '2025-2026', 1, 1, 5, 1, 2, 1, 1, 1, 0, '2025-03-15 22:12:30', '2025-03-15 22:12:30');
INSERT INTO `material_review` VALUES (30, 19, '2025-2026', 1, 2, 6, 2, 2, 1, 1, 1, 0, '2025-03-15 22:21:34', '2025-03-15 22:21:34');
INSERT INTO `material_review` VALUES (31, 20, '2024-2025', 1, 1, 5, 1, 2, 1, 1, 1, 0, '2025-03-16 13:07:58', '2025-03-16 13:07:58');
INSERT INTO `material_review` VALUES (32, 21, '2024-2025', 1, 1, 5, 1, 2, 1, 1, 1, 0, '2025-03-16 14:29:59', '2025-03-16 14:29:59');
INSERT INTO `material_review` VALUES (33, 22, '2025-2026', 1, 1, 1, 8, 2, 1, 1, 1, 0, '2025-03-16 14:59:24', '2025-03-16 14:59:24');
INSERT INTO `material_review` VALUES (34, 23, '2024-2025', 1, 4, 1, 8, 2, 1, 1, 1, 0, '2025-03-16 15:07:51', '2025-03-16 15:07:51');
INSERT INTO `material_review` VALUES (35, 24, '2025-2026', 1, 4, 5, 1, 2, 1, 1, 1, 0, '2025-03-16 15:24:19', '2025-03-16 15:24:19');
INSERT INTO `material_review` VALUES (36, 25, '2025-2026', 1, 1, 5, 1, 2, 1, 1, 1, 0, '2025-03-16 15:28:28', '2025-03-16 15:28:28');
INSERT INTO `material_review` VALUES (37, 26, '2025-2026', 1, 4, 5, 1, 2, 1, 1, 1, 0, '2025-03-16 15:31:58', '2025-03-16 15:31:58');
INSERT INTO `material_review` VALUES (38, 27, '2025-2026', 1, 4, 5, 1, 2, 1, 1, 1, 0, '2025-03-16 16:25:39', '2025-03-16 16:25:39');
INSERT INTO `material_review` VALUES (39, 28, '2025-2026', 1, 4, 5, 1, 2, 1, 1, 1, 0, '2025-03-16 16:36:07', '2025-03-16 16:36:07');
INSERT INTO `material_review` VALUES (40, 29, '2024-2025', 1, 1, 5, 1, 2, 1, 1, 1, 0, '2025-03-17 10:22:57', '2025-03-17 10:22:57');
INSERT INTO `material_review` VALUES (41, 30, '2025-2026', 1, 1, 5, 1, 2, 1, 1, 1, 0, '2025-03-18 09:12:11', '2025-03-18 09:12:11');
INSERT INTO `material_review` VALUES (42, 31, '2021-2022', 1, 1, 5, 1, 2, 1, 1, 1, 0, '2025-03-18 10:07:24', '2025-03-18 10:07:24');
INSERT INTO `material_review` VALUES (43, 32, '2021-2022', 1, 4, 5, 1, 2, 1, 1, 1, 0, '2025-03-18 11:45:11', '2025-03-18 11:45:11');
INSERT INTO `material_review` VALUES (44, 35, '2022-2023', 1, 4, 1, 3, 3, 3, 2, 1, 0, '2025-03-18 12:46:08', '2025-03-18 12:46:08');
INSERT INTO `material_review` VALUES (45, 36, '2021-2022', 1, 3, 1, 8, 12, 1, 1, 1, 0, '2025-03-19 11:13:40', '2025-03-19 11:13:40');
INSERT INTO `material_review` VALUES (46, 41, '2025-2026', 1, 1, 5, 1, 3, 5, 1, 1, 0, '2025-03-19 12:15:59', '2025-03-19 12:15:59');
INSERT INTO `material_review` VALUES (47, 42, '2024-2025', 1, 2, 2, 9, 3, 5, 1, 1, 0, '2025-03-19 12:21:30', '2025-03-19 12:21:30');
INSERT INTO `material_review` VALUES (48, 43, '2025-2026', 1, 2, 5, 1, 2, 1, 1, 1, 0, '2025-03-19 13:33:45', '2025-03-19 13:33:45');
INSERT INTO `material_review` VALUES (49, 44, '2024-2025', 1, 2, 5, 1, 2, 1, 1, 1, 0, '2025-03-19 13:35:43', '2025-03-19 13:35:43');

-- ----------------------------
-- Table structure for material_review_record
-- ----------------------------
DROP TABLE IF EXISTS `material_review_record`;
CREATE TABLE `material_review_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `review_id` bigint NOT NULL COMMENT '审核ID',
  `reviewer_id` bigint NOT NULL COMMENT '审核人ID',
  `reviewer_title` tinyint NOT NULL COMMENT '审核人职称：0-普通教师，1-课程负责人，2-专业负责人，3-副院长，4-教务人员',
  `result` tinyint NOT NULL COMMENT '审核结果：0-不通过，1-通过',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '审核意见',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_review_id`(`review_id` ASC) USING BTREE,
  INDEX `idx_reviewer_id`(`reviewer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教学材料审核记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material_review_record
-- ----------------------------
INSERT INTO `material_review_record` VALUES (54, 29, 8, 1, 1, '1', 0, '2025-03-15 22:13:20', '2025-03-15 22:13:20');
INSERT INTO `material_review_record` VALUES (55, 29, 9, 2, 1, '1', 0, '2025-03-15 22:13:33', '2025-03-15 22:13:33');
INSERT INTO `material_review_record` VALUES (56, 29, 10, 3, 1, '1', 0, '2025-03-15 22:13:44', '2025-03-15 22:13:44');
INSERT INTO `material_review_record` VALUES (57, 29, 1, 4, 1, '1', 0, '2025-03-15 22:13:56', '2025-03-15 22:13:56');
INSERT INTO `material_review_record` VALUES (58, 30, 8, 1, 1, '1', 0, '2025-03-15 22:28:55', '2025-03-15 22:28:55');
INSERT INTO `material_review_record` VALUES (59, 30, 9, 2, 1, '1', 0, '2025-03-15 22:30:44', '2025-03-15 22:30:44');
INSERT INTO `material_review_record` VALUES (60, 30, 10, 3, 0, '1', 0, '2025-03-15 22:32:03', '2025-03-15 22:32:03');
INSERT INTO `material_review_record` VALUES (61, 31, 8, 1, 1, '1', 0, '2025-03-16 13:08:29', '2025-03-16 13:08:29');
INSERT INTO `material_review_record` VALUES (62, 31, 9, 2, 1, '1', 0, '2025-03-16 13:09:32', '2025-03-16 13:09:32');
INSERT INTO `material_review_record` VALUES (63, 31, 10, 3, 1, '1', 0, '2025-03-16 13:10:21', '2025-03-16 13:10:21');
INSERT INTO `material_review_record` VALUES (64, 31, 1, 4, 1, '1', 0, '2025-03-16 13:10:38', '2025-03-16 13:10:38');
INSERT INTO `material_review_record` VALUES (65, 32, 8, 1, 1, '1', 0, '2025-03-16 14:30:35', '2025-03-16 14:30:35');
INSERT INTO `material_review_record` VALUES (66, 32, 9, 2, 1, '1', 0, '2025-03-16 14:30:45', '2025-03-16 14:30:45');
INSERT INTO `material_review_record` VALUES (67, 32, 10, 3, 1, '1', 0, '2025-03-16 14:30:56', '2025-03-16 14:30:56');
INSERT INTO `material_review_record` VALUES (68, 32, 1, 4, 1, '11', 0, '2025-03-16 14:31:31', '2025-03-16 14:31:31');
INSERT INTO `material_review_record` VALUES (69, 35, 8, 1, 1, '1', 0, '2025-03-16 15:24:46', '2025-03-16 15:24:46');
INSERT INTO `material_review_record` VALUES (70, 35, 9, 2, 1, '1', 0, '2025-03-16 15:25:04', '2025-03-16 15:25:04');
INSERT INTO `material_review_record` VALUES (71, 35, 10, 3, 1, '1', 0, '2025-03-16 15:25:14', '2025-03-16 15:25:14');
INSERT INTO `material_review_record` VALUES (72, 35, 1, 4, 1, '1', 0, '2025-03-16 15:25:30', '2025-03-16 15:25:30');
INSERT INTO `material_review_record` VALUES (73, 37, 8, 1, 1, '6', 0, '2025-03-16 15:32:10', '2025-03-16 15:32:10');
INSERT INTO `material_review_record` VALUES (74, 37, 9, 2, 1, '6', 0, '2025-03-16 15:32:27', '2025-03-16 15:32:27');
INSERT INTO `material_review_record` VALUES (75, 37, 10, 3, 1, '1', 0, '2025-03-16 15:32:42', '2025-03-16 15:32:42');
INSERT INTO `material_review_record` VALUES (76, 37, 1, 4, 1, '11', 0, '2025-03-16 15:57:58', '2025-03-16 15:57:58');
INSERT INTO `material_review_record` VALUES (77, 38, 8, 1, 1, '8888', 0, '2025-03-16 16:28:15', '2025-03-16 16:28:15');
INSERT INTO `material_review_record` VALUES (78, 38, 9, 2, 1, '8888', 0, '2025-03-16 16:28:27', '2025-03-16 16:28:27');
INSERT INTO `material_review_record` VALUES (79, 38, 10, 3, 1, '8888', 0, '2025-03-16 16:28:37', '2025-03-16 16:28:37');
INSERT INTO `material_review_record` VALUES (80, 38, 1, 4, 1, '1111', 0, '2025-03-16 16:28:53', '2025-03-16 16:28:53');
INSERT INTO `material_review_record` VALUES (81, 39, 8, 1, 1, '1', 0, '2025-03-16 16:36:25', '2025-03-16 16:36:25');
INSERT INTO `material_review_record` VALUES (82, 39, 9, 2, 1, '9999', 0, '2025-03-16 16:36:45', '2025-03-16 16:36:45');
INSERT INTO `material_review_record` VALUES (83, 39, 10, 3, 1, '1111', 0, '2025-03-16 16:36:56', '2025-03-16 16:36:56');
INSERT INTO `material_review_record` VALUES (84, 39, 1, 4, 1, '1111', 0, '2025-03-16 16:37:08', '2025-03-16 16:37:08');
INSERT INTO `material_review_record` VALUES (85, 40, 8, 1, 1, '1', 0, '2025-03-17 10:23:33', '2025-03-17 10:23:33');
INSERT INTO `material_review_record` VALUES (86, 40, 9, 2, 1, '1111', 0, '2025-03-17 10:33:23', '2025-03-17 10:33:23');
INSERT INTO `material_review_record` VALUES (87, 40, 10, 3, 1, '1', 0, '2025-03-17 10:33:36', '2025-03-17 10:33:36');
INSERT INTO `material_review_record` VALUES (88, 40, 1, 4, 1, '111111', 0, '2025-03-17 10:34:00', '2025-03-17 10:34:00');
INSERT INTO `material_review_record` VALUES (89, 36, 8, 1, 1, '1', 0, '2025-03-17 18:23:34', '2025-03-17 18:23:34');
INSERT INTO `material_review_record` VALUES (90, 36, 9, 2, 1, '1', 0, '2025-03-17 18:23:43', '2025-03-17 18:23:43');
INSERT INTO `material_review_record` VALUES (91, 36, 10, 3, 1, '2', 0, '2025-03-17 18:24:03', '2025-03-17 18:24:03');
INSERT INTO `material_review_record` VALUES (92, 36, 1, 4, 1, '111', 0, '2025-03-17 18:24:41', '2025-03-17 18:24:41');
INSERT INTO `material_review_record` VALUES (93, 41, 8, 1, 1, '111', 0, '2025-03-18 09:14:45', '2025-03-18 09:14:45');
INSERT INTO `material_review_record` VALUES (94, 41, 9, 2, 1, '1', 0, '2025-03-18 09:15:14', '2025-03-18 09:15:14');
INSERT INTO `material_review_record` VALUES (95, 41, 10, 3, 1, '11', 0, '2025-03-18 09:15:25', '2025-03-18 09:15:25');
INSERT INTO `material_review_record` VALUES (96, 41, 1, 4, 1, '111', 0, '2025-03-18 09:15:40', '2025-03-18 09:15:40');
INSERT INTO `material_review_record` VALUES (97, 42, 8, 1, 1, '11', 0, '2025-03-18 10:10:34', '2025-03-18 10:10:34');
INSERT INTO `material_review_record` VALUES (98, 42, 9, 2, 1, '1', 0, '2025-03-18 10:10:45', '2025-03-18 10:10:45');
INSERT INTO `material_review_record` VALUES (99, 42, 10, 3, 1, '1', 0, '2025-03-18 10:10:56', '2025-03-18 10:10:56');
INSERT INTO `material_review_record` VALUES (100, 42, 1, 4, 1, '2', 0, '2025-03-18 10:11:11', '2025-03-18 10:11:11');
INSERT INTO `material_review_record` VALUES (101, 43, 8, 1, 1, '1', 0, '2025-03-18 11:46:36', '2025-03-18 11:46:36');
INSERT INTO `material_review_record` VALUES (102, 43, 9, 2, 1, '11', 0, '2025-03-18 11:46:48', '2025-03-18 11:46:48');
INSERT INTO `material_review_record` VALUES (103, 43, 10, 3, 1, '1', 0, '2025-03-18 11:47:05', '2025-03-18 11:47:05');
INSERT INTO `material_review_record` VALUES (104, 43, 1, 4, 1, '1', 0, '2025-03-18 11:47:20', '2025-03-18 11:47:20');
INSERT INTO `material_review_record` VALUES (105, 46, 3, 1, 1, '1', 0, '2025-03-19 12:16:18', '2025-03-19 12:16:18');
INSERT INTO `material_review_record` VALUES (106, 46, 9, 2, 1, '1', 0, '2025-03-19 12:17:26', '2025-03-19 12:17:26');
INSERT INTO `material_review_record` VALUES (107, 46, 3, 3, 1, '1', 0, '2025-03-19 12:19:05', '2025-03-19 12:19:05');
INSERT INTO `material_review_record` VALUES (108, 46, 1, 4, 1, '2', 0, '2025-03-19 12:19:26', '2025-03-19 12:19:26');
INSERT INTO `material_review_record` VALUES (109, 47, 3, 1, 1, '1', 0, '2025-03-19 12:21:36', '2025-03-19 12:21:36');
INSERT INTO `material_review_record` VALUES (110, 48, 8, 1, 1, '111', 0, '2025-03-19 13:34:04', '2025-03-19 13:34:04');
INSERT INTO `material_review_record` VALUES (111, 48, 9, 2, 1, '1', 0, '2025-03-19 13:34:21', '2025-03-19 13:34:21');
INSERT INTO `material_review_record` VALUES (112, 48, 10, 3, 1, '1', 0, '2025-03-19 13:34:34', '2025-03-19 13:34:34');
INSERT INTO `material_review_record` VALUES (113, 48, 1, 4, 1, '1', 0, '2025-03-19 13:34:43', '2025-03-19 13:34:43');
INSERT INTO `material_review_record` VALUES (114, 49, 8, 1, 1, '1', 0, '2025-03-19 13:35:52', '2025-03-19 13:35:52');
INSERT INTO `material_review_record` VALUES (115, 49, 9, 2, 1, '1', 0, '2025-03-19 13:36:00', '2025-03-19 13:36:00');
INSERT INTO `material_review_record` VALUES (116, 49, 10, 3, 1, '1', 0, '2025-03-19 13:36:09', '2025-03-19 13:36:09');
INSERT INTO `material_review_record` VALUES (117, 49, 1, 4, 1, '1', 0, '2025-03-19 13:36:18', '2025-03-19 13:36:18');

-- ----------------------------
-- Table structure for material_task
-- ----------------------------
DROP TABLE IF EXISTS `material_task`;
CREATE TABLE `material_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '任务描述',
  `material_type_id` bigint NOT NULL COMMENT '材料类型ID',
  `course_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程ID列表，以逗号分隔',
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学年',
  `semester` tinyint NOT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `deadline` datetime NOT NULL COMMENT '截止日期',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态：0-未发布，1-进行中，2-已结束',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_material_type_id`(`material_type_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教学材料任务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material_task
-- ----------------------------
INSERT INTO `material_task` VALUES (1, '2025-2026学年第一学期教学大纲上传', '请各位教师按时上传教学大纲，确保教学材料的及时更新与完善', 1, '1,2,3', '2025-2026', 1, '2025-04-30 23:59:59', 1, 0, '2025-03-16 11:17:35', '2025-03-16 11:17:35');
INSERT INTO `material_task` VALUES (2, '2025-2026学年第一学期授课计划上传', '请各位教师按时上传授课计划，为学期教学做好充分准备', 2, '1,2,3,4', '2025-2026', 1, '2025-05-15 23:59:59', 1, 0, '2025-03-16 11:17:35', '2025-03-16 11:17:35');
INSERT INTO `material_task` VALUES (3, '2024-2025学年第二学期教学课件上传', '请各位教师上传本学期的教学课件，便于学生课前预习', 3, '1,2', '2024-2025', 2, '2025-03-30 23:59:59', 1, 0, '2025-03-16 11:17:35', '2025-03-16 11:17:35');
INSERT INTO `material_task` VALUES (4, '2024-2025学年第一学期教学大纲上传', '2024-2025学年第一学期教学大纲上传', 1, '1,2', '2024-2025', 1, '2025-04-04 00:00:00', 1, 0, '2025-03-16 12:27:36', '2025-03-16 12:47:32');
INSERT INTO `material_task` VALUES (5, '1111111', '1111111', 4, '1', '2025-2026', 1, '2025-04-04 16:00:00', 1, 0, '2025-03-16 14:13:15', '2025-03-16 14:13:15');

-- ----------------------------
-- Table structure for material_task_completion
-- ----------------------------
DROP TABLE IF EXISTS `material_task_completion`;
CREATE TABLE `material_task_completion`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `teacher_id` bigint NOT NULL COMMENT '教师ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `material_id` bigint NOT NULL COMMENT '材料ID',
  `completion_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '完成时间',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_task_teacher_course`(`task_id` ASC, `teacher_id` ASC, `course_id` ASC) USING BTREE,
  INDEX `idx_task_id`(`task_id` ASC) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE,
  INDEX `idx_material_id`(`material_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教学材料任务完成记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material_task_completion
-- ----------------------------
INSERT INTO `material_task_completion` VALUES (2, 5, 2, 1, 28, '2025-03-16 16:37:08', 0, '2025-03-16 16:37:08', '2025-03-16 16:37:08');
INSERT INTO `material_task_completion` VALUES (3, 4, 2, 1, 29, '2025-03-17 10:34:00', 0, '2025-03-17 10:34:00', '2025-03-17 10:34:00');
INSERT INTO `material_task_completion` VALUES (4, 1, 3, 5, 41, '2025-03-19 12:19:26', 0, '2025-03-19 12:19:26', '2025-03-19 12:19:26');

-- ----------------------------
-- Table structure for material_type
-- ----------------------------
DROP TABLE IF EXISTS `material_type`;
CREATE TABLE `material_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '类型描述',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教学材料类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material_type
-- ----------------------------
INSERT INTO `material_type` VALUES (1, '教学大纲', '课程教学大纲', 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `material_type` VALUES (2, '授课计划', '课程授课计划', 0, '2025-03-12 13:40:11', '2025-03-12 13:40:11');
INSERT INTO `material_type` VALUES (3, '教学课件', '课程教学课件', 0, '2025-03-13 08:21:19', '2025-03-13 08:21:19');
INSERT INTO `material_type` VALUES (4, '实验指导', '实验课程指导', 0, '2025-03-13 08:21:19', '2025-03-13 08:21:19');

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_student_course`(`student_id` ASC, `course_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学生课程关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of student_course
-- ----------------------------
INSERT INTO `student_course` VALUES (1, 4, 1, 0, '2025-03-06 16:38:00', '2025-03-12 12:36:47');
INSERT INTO `student_course` VALUES (2, 4, 2, 0, '2025-03-06 16:38:00', '2025-03-12 12:36:46');
INSERT INTO `student_course` VALUES (3, 5, 1, 1, '2025-03-06 16:38:00', '2025-03-17 15:33:28');
INSERT INTO `student_course` VALUES (5, 6, 2, 0, '2025-03-06 16:38:00', '2025-03-06 16:38:00');
INSERT INTO `student_course` VALUES (6, 6, 3, 0, '2025-03-06 16:38:00', '2025-03-06 16:38:00');
INSERT INTO `student_course` VALUES (10, 10, 1, 0, '2025-03-12 08:44:45', '2025-03-12 08:44:45');
INSERT INTO `student_course` VALUES (11, 10, 2, 0, '2025-03-12 08:44:48', '2025-03-12 08:44:48');
INSERT INTO `student_course` VALUES (12, 10, 3, 0, '2025-03-12 08:44:53', '2025-03-12 08:44:53');
INSERT INTO `student_course` VALUES (13, 5, 2, 0, '2025-03-12 09:35:59', '2025-03-12 09:35:59');
INSERT INTO `student_course` VALUES (39, 5, 3, 1, '2025-03-17 19:17:36', '2025-03-17 19:17:40');
INSERT INTO `student_course` VALUES (43, 5, 4, 0, '2025-03-17 21:57:34', '2025-03-17 21:57:34');
INSERT INTO `student_course` VALUES (44, 4, 3, 0, '2025-03-18 10:11:35', '2025-03-18 10:11:35');
INSERT INTO `student_course` VALUES (45, 4, 5, 1, '2025-03-20 16:07:35', '2025-03-20 16:07:43');
INSERT INTO `student_course` VALUES (46, 5, 7, 1, '2025-03-20 16:12:28', '2025-03-20 16:14:30');
INSERT INTO `student_course` VALUES (48, 5, 5, 0, '2025-03-20 16:41:04', '2025-03-20 16:41:04');

-- ----------------------------
-- Table structure for teacher_title
-- ----------------------------
DROP TABLE IF EXISTS `teacher_title`;
CREATE TABLE `teacher_title`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `teacher_id` bigint NOT NULL COMMENT '教师ID',
  `title_type` tinyint NOT NULL COMMENT '职称类型：0-普通教师，1-课程负责人，2-专业负责人，3-副院长',
  `course_id` bigint NULL DEFAULT NULL COMMENT '所负责课程ID，仅当title_type=1时有效',
  `major_id` bigint NULL DEFAULT NULL COMMENT '所负责专业ID，仅当title_type=2时有效',
  `college_id` bigint NULL DEFAULT NULL COMMENT '所属学院ID，仅当title_type=3时有效',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_teacher_id`(`teacher_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '教师职称表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher_title
-- ----------------------------
INSERT INTO `teacher_title` VALUES (1, 2, 0, NULL, NULL, NULL, 1, '2025-03-12 13:40:11', '2025-03-15 22:27:28');
INSERT INTO `teacher_title` VALUES (2, 2, 0, 1, NULL, NULL, 1, '2025-03-12 13:40:11', '2025-03-15 22:27:28');
INSERT INTO `teacher_title` VALUES (3, 3, 0, NULL, NULL, NULL, 1, '2025-03-12 13:40:11', '2025-03-17 18:26:01');
INSERT INTO `teacher_title` VALUES (4, 3, 2, NULL, 2, NULL, 1, '2025-03-12 13:40:11', '2025-03-17 18:26:01');
INSERT INTO `teacher_title` VALUES (5, 3, 3, NULL, NULL, 1, 1, '2025-03-12 13:40:11', '2025-03-17 18:26:01');
INSERT INTO `teacher_title` VALUES (6, 8, 1, 1, NULL, NULL, 0, '2025-03-13 08:38:11', '2025-03-13 08:38:11');
INSERT INTO `teacher_title` VALUES (7, 9, 2, NULL, 1, NULL, 1, '2025-03-13 08:38:11', '2025-03-15 22:29:10');
INSERT INTO `teacher_title` VALUES (8, 10, 3, NULL, NULL, 1, 0, '2025-03-13 08:38:11', '2025-03-13 08:38:11');
INSERT INTO `teacher_title` VALUES (16, 2, 0, NULL, NULL, NULL, 1, '2025-03-15 22:27:28', '2025-03-15 22:28:05');
INSERT INTO `teacher_title` VALUES (17, 2, 1, 1, NULL, NULL, 1, '2025-03-15 22:27:28', '2025-03-15 22:28:05');
INSERT INTO `teacher_title` VALUES (18, 2, 0, NULL, NULL, NULL, 1, '2025-03-15 22:28:06', '2025-03-17 12:29:52');
INSERT INTO `teacher_title` VALUES (19, 9, 2, NULL, 1, NULL, 0, '2025-03-15 22:29:50', '2025-03-15 22:29:50');
INSERT INTO `teacher_title` VALUES (33, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 12:49:24', '2025-03-17 12:49:47');
INSERT INTO `teacher_title` VALUES (34, 2, 1, 1, NULL, NULL, 1, '2025-03-17 12:49:24', '2025-03-17 12:49:47');
INSERT INTO `teacher_title` VALUES (35, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 12:49:47', '2025-03-17 12:49:57');
INSERT INTO `teacher_title` VALUES (36, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 12:49:58', '2025-03-17 13:42:02');
INSERT INTO `teacher_title` VALUES (37, 2, 1, 1, NULL, NULL, 1, '2025-03-17 12:49:58', '2025-03-17 13:42:02');
INSERT INTO `teacher_title` VALUES (38, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 13:42:03', '2025-03-17 18:25:20');
INSERT INTO `teacher_title` VALUES (39, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:25:21', '2025-03-17 18:25:24');
INSERT INTO `teacher_title` VALUES (40, 2, 1, 1, NULL, NULL, 1, '2025-03-17 18:25:21', '2025-03-17 18:25:24');
INSERT INTO `teacher_title` VALUES (41, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:25:25', '2025-03-17 18:26:06');
INSERT INTO `teacher_title` VALUES (42, 3, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:02', '2025-03-17 18:26:14');
INSERT INTO `teacher_title` VALUES (43, 3, 3, NULL, NULL, 1, 1, '2025-03-17 18:26:02', '2025-03-17 18:26:14');
INSERT INTO `teacher_title` VALUES (44, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:06', '2025-03-17 18:26:09');
INSERT INTO `teacher_title` VALUES (45, 2, 1, 1, NULL, NULL, 1, '2025-03-17 18:26:06', '2025-03-17 18:26:09');
INSERT INTO `teacher_title` VALUES (46, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:10', '2025-03-17 18:26:27');
INSERT INTO `teacher_title` VALUES (47, 3, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:15', '2025-03-17 18:26:18');
INSERT INTO `teacher_title` VALUES (48, 3, 2, NULL, 1, NULL, 1, '2025-03-17 18:26:15', '2025-03-17 18:26:18');
INSERT INTO `teacher_title` VALUES (49, 3, 3, NULL, NULL, 1, 1, '2025-03-17 18:26:15', '2025-03-17 18:26:18');
INSERT INTO `teacher_title` VALUES (50, 3, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:18', '2025-03-17 18:26:23');
INSERT INTO `teacher_title` VALUES (51, 3, 3, NULL, NULL, 1, 1, '2025-03-17 18:26:18', '2025-03-17 18:26:23');
INSERT INTO `teacher_title` VALUES (52, 3, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:23', '2025-03-17 18:26:31');
INSERT INTO `teacher_title` VALUES (53, 3, 1, 1, NULL, NULL, 1, '2025-03-17 18:26:23', '2025-03-17 18:26:31');
INSERT INTO `teacher_title` VALUES (54, 3, 3, NULL, NULL, 1, 1, '2025-03-17 18:26:23', '2025-03-17 18:26:31');
INSERT INTO `teacher_title` VALUES (55, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:28', '2025-03-17 18:26:35');
INSERT INTO `teacher_title` VALUES (56, 2, 1, 1, NULL, NULL, 1, '2025-03-17 18:26:28', '2025-03-17 18:26:35');
INSERT INTO `teacher_title` VALUES (57, 3, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:31', '2025-03-17 18:26:40');
INSERT INTO `teacher_title` VALUES (58, 3, 3, NULL, NULL, 1, 1, '2025-03-17 18:26:31', '2025-03-17 18:26:40');
INSERT INTO `teacher_title` VALUES (59, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:35', '2025-03-17 18:29:17');
INSERT INTO `teacher_title` VALUES (60, 3, 0, NULL, NULL, NULL, 1, '2025-03-17 18:26:41', '2025-03-18 12:45:09');
INSERT INTO `teacher_title` VALUES (61, 3, 2, NULL, 1, NULL, 1, '2025-03-17 18:26:41', '2025-03-18 12:45:09');
INSERT INTO `teacher_title` VALUES (62, 3, 3, NULL, NULL, 1, 1, '2025-03-17 18:26:41', '2025-03-18 12:45:09');
INSERT INTO `teacher_title` VALUES (63, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:29:18', '2025-03-17 18:29:20');
INSERT INTO `teacher_title` VALUES (64, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:29:21', '2025-03-17 18:29:31');
INSERT INTO `teacher_title` VALUES (65, 2, 1, 1, NULL, NULL, 1, '2025-03-17 18:29:21', '2025-03-17 18:29:31');
INSERT INTO `teacher_title` VALUES (66, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:29:32', '2025-03-17 18:30:30');
INSERT INTO `teacher_title` VALUES (67, 2, 1, 2, NULL, NULL, 1, '2025-03-17 18:29:32', '2025-03-17 18:30:30');
INSERT INTO `teacher_title` VALUES (68, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:30:30', '2025-03-17 18:30:33');
INSERT INTO `teacher_title` VALUES (69, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:30:34', '2025-03-17 18:30:38');
INSERT INTO `teacher_title` VALUES (70, 2, 1, 1, NULL, NULL, 1, '2025-03-17 18:30:34', '2025-03-17 18:30:38');
INSERT INTO `teacher_title` VALUES (71, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:30:38', '2025-03-17 18:30:40');
INSERT INTO `teacher_title` VALUES (72, 2, 2, NULL, 1, NULL, 1, '2025-03-17 18:30:38', '2025-03-17 18:30:40');
INSERT INTO `teacher_title` VALUES (73, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 18:30:41', '2025-03-17 21:26:23');
INSERT INTO `teacher_title` VALUES (74, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 21:26:23', '2025-03-17 21:26:25');
INSERT INTO `teacher_title` VALUES (75, 2, 1, 1, NULL, NULL, 1, '2025-03-17 21:26:23', '2025-03-17 21:26:25');
INSERT INTO `teacher_title` VALUES (76, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 21:26:26', '2025-03-17 21:57:23');
INSERT INTO `teacher_title` VALUES (77, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 21:57:24', '2025-03-17 21:57:26');
INSERT INTO `teacher_title` VALUES (78, 2, 1, 1, NULL, NULL, 1, '2025-03-17 21:57:24', '2025-03-17 21:57:26');
INSERT INTO `teacher_title` VALUES (79, 2, 0, NULL, NULL, NULL, 1, '2025-03-17 21:57:26', '2025-03-18 12:59:31');
INSERT INTO `teacher_title` VALUES (80, 3, 0, NULL, NULL, NULL, 1, '2025-03-18 12:45:10', '2025-03-18 12:45:52');
INSERT INTO `teacher_title` VALUES (81, 3, 1, 3, NULL, NULL, 1, '2025-03-18 12:45:10', '2025-03-18 12:45:52');
INSERT INTO `teacher_title` VALUES (82, 3, 2, NULL, 1, NULL, 1, '2025-03-18 12:45:10', '2025-03-18 12:45:52');
INSERT INTO `teacher_title` VALUES (83, 3, 3, NULL, NULL, 1, 1, '2025-03-18 12:45:10', '2025-03-18 12:45:52');
INSERT INTO `teacher_title` VALUES (84, 3, 0, NULL, NULL, NULL, 1, '2025-03-18 12:45:53', '2025-03-19 12:15:37');
INSERT INTO `teacher_title` VALUES (85, 3, 1, 3, NULL, NULL, 1, '2025-03-18 12:45:53', '2025-03-19 12:15:37');
INSERT INTO `teacher_title` VALUES (86, 3, 2, NULL, 1, NULL, 1, '2025-03-18 12:45:53', '2025-03-19 12:15:37');
INSERT INTO `teacher_title` VALUES (87, 3, 3, NULL, NULL, 1, 1, '2025-03-18 12:45:53', '2025-03-19 12:15:37');
INSERT INTO `teacher_title` VALUES (88, 2, 0, NULL, NULL, NULL, 0, '2025-03-18 12:59:31', '2025-03-18 12:59:31');
INSERT INTO `teacher_title` VALUES (89, 12, 0, NULL, NULL, NULL, 1, '2025-03-19 11:03:09', '2025-03-19 11:03:35');
INSERT INTO `teacher_title` VALUES (90, 12, 0, NULL, NULL, NULL, 0, '2025-03-19 11:03:35', '2025-03-19 11:03:35');
INSERT INTO `teacher_title` VALUES (91, 3, 0, NULL, NULL, NULL, 1, '2025-03-19 12:15:37', '2025-03-19 12:16:52');
INSERT INTO `teacher_title` VALUES (92, 3, 1, 5, NULL, NULL, 1, '2025-03-19 12:15:37', '2025-03-19 12:16:52');
INSERT INTO `teacher_title` VALUES (93, 3, 2, NULL, 1, NULL, 1, '2025-03-19 12:15:37', '2025-03-19 12:16:52');
INSERT INTO `teacher_title` VALUES (94, 3, 3, NULL, NULL, 1, 1, '2025-03-19 12:15:37', '2025-03-19 12:16:52');
INSERT INTO `teacher_title` VALUES (95, 3, 0, NULL, NULL, NULL, 1, '2025-03-19 12:16:52', '2025-03-19 12:18:54');
INSERT INTO `teacher_title` VALUES (96, 3, 1, 5, NULL, NULL, 1, '2025-03-19 12:16:52', '2025-03-19 12:18:54');
INSERT INTO `teacher_title` VALUES (97, 3, 2, NULL, 1, NULL, 1, '2025-03-19 12:16:52', '2025-03-19 12:18:54');
INSERT INTO `teacher_title` VALUES (98, 3, 3, NULL, NULL, 1, 1, '2025-03-19 12:16:52', '2025-03-19 12:18:54');
INSERT INTO `teacher_title` VALUES (99, 3, 0, NULL, NULL, NULL, 0, '2025-03-19 12:18:54', '2025-03-19 12:18:54');
INSERT INTO `teacher_title` VALUES (100, 3, 1, 5, NULL, NULL, 0, '2025-03-19 12:18:54', '2025-03-19 12:18:54');
INSERT INTO `teacher_title` VALUES (101, 3, 2, NULL, 1, NULL, 0, '2025-03-19 12:18:54', '2025-03-19 12:18:54');
INSERT INTO `teacher_title` VALUES (102, 3, 3, NULL, NULL, 1, 0, '2025-03-19 12:18:54', '2025-03-19 12:18:54');

-- ----------------------------
-- Table structure for temp_material
-- ----------------------------
DROP TABLE IF EXISTS `temp_material`;
CREATE TABLE `temp_material`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '材料ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '材料名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '材料描述',
  `course_id` bigint NOT NULL COMMENT '所属课程ID',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件路径',
  `file_size` bigint NOT NULL COMMENT '文件大小(字节)',
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `upload_user_id` bigint NOT NULL COMMENT '上传用户ID',
  `type` tinyint NOT NULL DEFAULT 0 COMMENT '材料类型：0-课程材料，1-学生资料',
  `academic_year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学年',
  `semester` tinyint NULL DEFAULT NULL COMMENT '学期：1-第一学期，2-第二学期',
  `material_type_id` bigint NULL DEFAULT NULL COMMENT '材料类型ID',
  `task_id` bigint NULL DEFAULT NULL COMMENT '关联的任务ID',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_task_id`(`task_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '临时材料表（待审核）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of temp_material
-- ----------------------------
INSERT INTO `temp_material` VALUES (17, '授课', 'sk', 1, '2025/03/1d6606e7-3d83-4706-8d09-7a3c84152e6d.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 2, NULL, 0, '2025-03-15 22:02:25', '2025-03-15 22:02:25');
INSERT INTO `temp_material` VALUES (18, '2025-2026Java教学大纲', '2025-2026Java教学大纲', 1, '2025/03/3279842e-34a0-4437-9874-1d12b3f4aa66.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 1, NULL, 1, '2025-03-15 22:12:30', '2025-03-15 22:13:55');
INSERT INTO `temp_material` VALUES (19, '2025-2026Java授课计划', '2025-2026Java授课计划', 1, '2025/03/b2a86354-d947-4721-b373-e627e9fcd532.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 2, NULL, 0, '2025-03-15 22:21:33', '2025-03-15 22:21:33');
INSERT INTO `temp_material` VALUES (20, '2024-2025学年第一学期教学大纲上传', '2024-2025学年第一学期教学大纲上传', 1, '2025/03/fb31c3fa-17d6-473d-95c4-c7d03fd5cd20.doc', 85480, 'doc', 2, 0, '2024-2025', 1, 1, NULL, 1, '2025-03-16 13:07:58', '2025-03-16 13:10:37');
INSERT INTO `temp_material` VALUES (21, '2024-2025第一学期java教学大纲', '2024-2025第一学期java教学大纲', 1, '2025/03/a685e6a0-6143-4b76-8663-2ecc61ca648e.doc', 85480, 'doc', 2, 0, '2024-2025', 1, 1, 5, 1, '2025-03-16 14:29:58', '2025-03-16 14:32:46');
INSERT INTO `temp_material` VALUES (23, 'awdawdawd', 'awdawdawd', 1, '2025/03/cf101932-ab20-4c75-bf5f-e3ece5b2961c.doc', 85480, 'doc', 2, 0, '2024-2025', 1, 4, NULL, 0, '2025-03-16 15:07:51', '2025-03-16 15:07:51');
INSERT INTO `temp_material` VALUES (24, '11111', '111111', 1, '2025/03/d9b6a4ba-73d7-4be1-971d-94888932ac72.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 4, 5, 1, '2025-03-16 15:24:19', '2025-03-16 15:25:30');
INSERT INTO `temp_material` VALUES (25, '2222', '2222', 1, '2025/03/fc3b06c8-896a-4d2b-ab7e-2c29955fd488.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 1, NULL, 1, '2025-03-16 15:28:27', '2025-03-17 18:24:41');
INSERT INTO `temp_material` VALUES (26, '66666', '6666', 1, '2025/03/3f416dbe-d4c8-4589-a744-997a2e3f8eed.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 4, 5, 1, '2025-03-16 15:31:58', '2025-03-16 15:57:57');
INSERT INTO `temp_material` VALUES (27, '888888', '88888', 1, '2025/03/87ab087c-c124-46e5-b2f3-739c21564c25.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 4, 5, 1, '2025-03-16 16:25:38', '2025-03-16 16:28:53');
INSERT INTO `temp_material` VALUES (28, '999999', '99999999', 1, '2025/03/84e00899-e4e9-4063-a3d5-db32cc46c8b7.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 4, 5, 1, '2025-03-16 16:36:07', '2025-03-16 16:37:08');
INSERT INTO `temp_material` VALUES (29, '2024-2025学年第一学期Java教学大纲', '2024-2025学年第一学期Java教学大纲', 1, '2025/03/8d4f9311-60a9-4c7c-a3fe-152b3b2508c8.doc', 85480, 'doc', 2, 0, '2024-2025', 1, 1, 4, 1, '2025-03-17 10:22:56', '2025-03-17 10:33:59');
INSERT INTO `temp_material` VALUES (30, '097867578', '11111', 1, '2025/03/8aa10dcd-855b-435c-912a-47712858358a.xlsx', 9199, 'xlsx', 2, 0, '2025-2026', 1, 1, NULL, 1, '2025-03-18 09:12:10', '2025-03-18 09:15:40');
INSERT INTO `temp_material` VALUES (31, '更改路径后测试', '111111', 1, '2025/03/c0169a73-4d8a-41d3-933c-9eb89b8a3ce7.xlsx', 9199, 'xlsx', 2, 0, '2021-2022', 1, 1, NULL, 1, '2025-03-18 10:07:23', '2025-03-18 10:11:10');
INSERT INTO `temp_material` VALUES (32, '1111', '1111', 1, '2025/03/b37228b5-c044-403b-9e4e-3a4233a0a08c.xlsx', 9199, 'xlsx', 2, 0, '2021-2022', 1, 4, NULL, 1, '2025-03-18 11:45:11', '2025-03-18 11:47:19');
INSERT INTO `temp_material` VALUES (35, '111', '1111', 3, '2025/03/cb1cd66b-9a14-4d27-a6e9-cd4dada391b7.xlsx', 9199, 'xlsx', 3, 0, '2022-2023', 1, 4, NULL, 0, '2025-03-18 12:46:07', '2025-03-18 12:46:07');
INSERT INTO `temp_material` VALUES (36, '教学课件', '教学课件', 1, '2025/03/2e397db0-4f73-42ee-9242-dc39b6e5b7a6.xlsx', 9199, 'xlsx', 12, 0, '2021-2022', 1, 3, NULL, 0, '2025-03-19 11:13:40', '2025-03-19 11:13:40');
INSERT INTO `temp_material` VALUES (41, '2025-2026学年第一学期javaEE教学大纲', '2025-2026学年第一学期javaEE教学大纲', 5, '2025/03/37c60cde-663d-4e41-8975-c76bd3aa427d.xlsx', 9199, 'xlsx', 3, 0, '2025-2026', 1, 1, 1, 1, '2025-03-19 12:15:59', '2025-03-19 12:19:26');
INSERT INTO `temp_material` VALUES (42, '2024-2055javaEE授课计划', '2024-2055javaEE授课计划', 5, '2025/03/b7e8dd1f-394c-41fd-a327-4cefc93d95d2.doc', 85480, 'doc', 3, 0, '2024-2025', 1, 2, NULL, 0, '2025-03-19 12:21:29', '2025-03-19 12:21:29');
INSERT INTO `temp_material` VALUES (43, '2025-2026Java程序设计授课计划', '2025-2026Java程序设计授课计划', 1, '2025/03/fd4a9b55-c24f-42cf-b9ae-487624767474.doc', 85480, 'doc', 2, 0, '2025-2026', 1, 2, NULL, 1, '2025-03-19 13:33:44', '2025-03-19 13:34:42');
INSERT INTO `temp_material` VALUES (44, '2024-2025学年Java程序设计授课计划', '2024-2025学年Java程序设计授课计划', 1, '2025/03/768c672a-d813-4fd4-a66f-7a51a75f7ac7.xlsx', 9199, 'xlsx', 2, 0, '2024-2025', 1, 2, NULL, 1, '2025-03-19 13:35:42', '2025-03-19 13:36:17');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名/学号/工号',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `role` tinyint NOT NULL DEFAULT 0 COMMENT '角色：0-学生，1-教师，2-管理员',
  `class_id` bigint NULL DEFAULT NULL COMMENT '班级ID（仅学生有效）',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：0-未删除，1-已删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', '系统管理员', 'admin@qq.com', '13900000000', '/static/avatars/avatar_1_a27d89aab6744c6ba36bdbf5a0470c9f.jpg', 2, NULL, 1, 0, '2025-03-06 16:36:54', '2025-03-15 17:42:53');
INSERT INTO `user` VALUES (2, 'teacher1', '123456', '张老师', 'teacher1@tcr.com', '13800000001', '/static/avatars/avatar_2_50266d93a43d4787868a67ed76a0d499.jpg', 1, NULL, 1, 0, '2025-03-06 16:37:40', '2025-03-15 22:27:10');
INSERT INTO `user` VALUES (3, 'teacher2', '123456', '李老师', 'teacher2@tcr.com', '13800000002', NULL, 1, NULL, 1, 0, '2025-03-06 16:37:40', '2025-03-12 08:38:59');
INSERT INTO `user` VALUES (4, 'student1', '123456', '王同学', 'student1@tcr.com', '13800000003', '/static/avatars/avatar_4_fd76ed9532b54a2fac97af593188bb5e.jpg', 0, 1, 1, 0, '2025-03-06 16:37:40', '2025-03-15 17:47:39');
INSERT INTO `user` VALUES (5, 'student2', '123456', '陈同学', 'student2@tcr.com', '13800000004', NULL, 0, 3, 1, 0, '2025-03-06 16:37:40', '2025-03-18 14:46:37');
INSERT INTO `user` VALUES (6, 'student3', '123456', '刘同学', 'student3@tcr.com', '13800000005', NULL, 0, 3, 1, 0, '2025-03-06 16:37:40', '2025-03-15 17:30:42');
INSERT INTO `user` VALUES (7, 'student4', '123456', '小杨', '2868620134@qq.com', '13912387401', NULL, 0, 1, 1, 0, '2025-03-10 15:45:49', '2025-03-15 17:30:42');
INSERT INTO `user` VALUES (8, 'java_course_leader', '123456', 'Java课程负责人', 'java_leader@example.com', '13800000001', NULL, 1, NULL, 1, 0, '2025-03-13 08:38:11', '2025-03-13 08:38:11');
INSERT INTO `user` VALUES (9, 'cs_major_leader', '123456', '计算机专业负责人', 'cs_leader@example.com', '13800000002', NULL, 1, NULL, 1, 0, '2025-03-13 08:38:11', '2025-03-13 08:38:11');
INSERT INTO `user` VALUES (10, 'vice_dean', '123456', '教学副院长', 'vice_dean@example.com', '13800000003', NULL, 1, NULL, 1, 0, '2025-03-13 08:38:11', '2025-03-13 08:38:11');
INSERT INTO `user` VALUES (11, '23091231034', '123456', 'yzh', '2868620134@qq.com', '13900000000', NULL, 0, 1, 1, 0, '2025-03-15 17:39:47', '2025-03-15 17:50:35');
INSERT INTO `user` VALUES (12, 'teacher3', '123456', '杨老师', 'teacher3@example.com', '13800007569', NULL, 1, NULL, 1, 0, '2025-03-19 11:03:03', '2025-03-19 11:04:21');

SET FOREIGN_KEY_CHECKS = 1;
