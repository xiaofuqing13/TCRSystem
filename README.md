<![CDATA[[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.7.3-brightgreen)](https://spring.io/)
[![Vue.js](https://img.shields.io/badge/Vue.js-2.x-4FC08D)](https://vuejs.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)](https://www.mysql.com/)
[![Redis](https://img.shields.io/badge/Redis-latest-red)](https://redis.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

# 📚 TCRSystem — 教学课程资源管理系统

> 一个基于 **Spring Boot + Vue.js** 前后端分离架构的教学课程资源管理平台，支持管理员、教师、学生三种角色，涵盖课程管理、教材上传审核、作业发布与提交、实时消息推送等完整教学流程。

---

## ✨ 功能特性

### 🔒 管理员端
- 用户管理（教师 / 学生 / 教务管理员）
- 课程与专业管理
- 教材审核与统计分析
- 教材任务下发与完成度追踪

### 📚 教师端
- 课程教材上传与管理
- 作业发布与批改
- 教材任务响应
- 课程反馈查看
- 资源共享

### 🎓 学生端
- 课程浏览与教材下载
- 作业查看与在线提交
- 课程反馈交流

---

## 🔧 系统架构

| 层级 | 技术 |
|------|------|
| **前端框架** | Vue.js 2.x + Element UI + Vuex + Vue Router + Axios + SCSS |
| **后端框架** | Spring Boot 2.7.3 + Spring Security + MyBatis-Plus |
| **数据库** | MySQL 8.0 |
| **缓存** | Redis |
| **对象存储** | MinIO（文件上传） |
| **认证** | JWT 无状态身份认证 |
| **实时通信** | WebSocket 实时消息推送 |
| **API 文档** | Knife4j API 文档自动生成 |

---

## 📂 项目结构

```
TCRSystem/
├── backend/          # Spring Boot 后端
│   ├── src/main/java/com/tcr/system/
│   │   ├── controller/    # REST API 控制器
│   │   ├── service/       # 业务逻辑
│   │   ├── mapper/        # MyBatis-Plus 数据映射
│   │   ├── entity/        # 数据实体
│   │   ├── config/        # 配置类 (Security, Redis, WebSocket)
│   │   └── utils/         # 工具类 (JWT, 文件处理)
│   └── pom.xml
├── frontend/         # Vue.js 前端
│   ├── src/
│   │   ├── views/         # 页面组件
│   │   ├── components/    # 公共组件
│   │   ├── router/        # 路由配置
│   │   ├── store/         # Vuex 状态管理
│   │   └── api/           # API 接口
│   └── package.json
└── tcr_system.sql    # 数据库初始化脚本
```

---

## 🚀 快速开始

### 环境要求
- JDK 8+
- Node.js 14+
- MySQL 8.0+
- Redis 6.0+
- MinIO

### 1️⃣ 数据库初始化

```bash
mysql -u root -p < tcr_system.sql
```

### 2️⃣ 后端启动

```bash
cd backend
# 修改 application.yml 中的数据库/Redis/MinIO 配置
mvn spring-boot:run
```

### 3️⃣ 前端启动

```bash
cd frontend
npm install
npm run serve
```

### 4️⃣ 访问系统
- 前端: http://localhost:8080
- API 文档: http://localhost:8081/doc.html

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).
]]>
