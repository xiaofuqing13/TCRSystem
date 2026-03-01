# TCRSystem — 教学课程资源管理系统

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.3-brightgreen)](https://spring.io/)
[![Vue.js](https://img.shields.io/badge/Vue.js-2.x-4FC08D)](https://vuejs.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)](https://www.mysql.com/)
[![Redis](https://img.shields.io/badge/Redis-latest-red)](https://redis.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

## 项目背景

高校教学中，课程资料的分发、作业的收集批改、教材任务的下达跟踪，长期依赖微信群/QQ群/邮件等分散渠道，存在 **资料版本混乱、作业收集效率低、进度难以追踪** 等问题。

本项目针对这些痛点，开发了一套前后端分离的教学课程资源管理平台：
- 管理员可以统一管理用户、课程、审核教材并追踪任务完成度
- 教师可以上传教材、发布作业、在线批改、查看反馈
- 学生可以浏览课程资料、下载教材、在线提交作业

通过 WebSocket 实时推送消息通知，各角色能及时获取动态，避免信息遗漏。

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端 | Vue.js 2.x + Element UI + Vuex + Vue Router + Axios |
| 后端 | Spring Boot 2.7.3 + Spring Security + MyBatis-Plus |
| 数据库 | MySQL 8.0 |
| 缓存 | Redis |
| 文件存储 | MinIO |
| 身份认证 | JWT |
| 消息推送 | WebSocket |
| 接口文档 | Knife4j |

## 功能概览

**管理员端：** 用户管理（教师/学生/教务管理员）、课程与专业管理、教材审核与统计、教材任务下发与完成度追踪

**教师端：** 课程教材上传与管理、作业发布与批改、教材任务响应、课程反馈查看、资源共享

**学生端：** 课程浏览与教材下载、作业查看与在线提交、课程反馈交流

## 项目结构

```
TCRSystem/
├── backend/                # 后端（Spring Boot）
│   ├── src/main/java/
│   │   ├── controller/     # 接口层
│   │   ├── service/        # 业务逻辑
│   │   ├── mapper/         # 数据访问
│   │   ├── entity/         # 数据实体
│   │   ├── config/         # 配置（Security、Redis、WebSocket）
│   │   └── utils/          # 工具类（JWT、文件处理）
│   └── pom.xml
├── frontend/               # 前端（Vue.js）
│   ├── src/
│   │   ├── views/          # 页面
│   │   ├── components/     # 公共组件
│   │   ├── router/         # 路由
│   │   ├── store/          # 状态管理
│   │   └── api/            # 接口封装
│   └── package.json
└── tcr_system.sql          # 数据库初始化脚本
```

## 快速开始

**环境要求：** JDK 8+、Node.js 14+、MySQL 8.0+、Redis 6.0+、MinIO

```bash
# 1. 初始化数据库
mysql -u root -p < tcr_system.sql

# 2. 启动后端（先修改 application.yml 中数据库/Redis/MinIO 配置）
cd backend
mvn spring-boot:run

# 3. 启动前端
cd frontend
npm install
npm run serve
```

启动后访问 http://localhost:8080 进入系统，接口文档地址 http://localhost:8081/doc.html

## 开源协议

MIT License
