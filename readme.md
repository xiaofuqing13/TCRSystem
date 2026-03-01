<![CDATA[# 📚 TCRSystem — 教学课程资源管理系统

<p align="center">
  <img src="https://img.shields.io/badge/Spring%20Boot-2.7.3-brightgreen?logo=springboot" alt="Spring Boot">
  <img src="https://img.shields.io/badge/Vue.js-2.x-4FC08D?logo=vue.js" alt="Vue.js">
  <img src="https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Redis-latest-DC382D?logo=redis&logoColor=white" alt="Redis">
  <img src="https://img.shields.io/badge/License-MIT-blue" alt="License">
</p>

> 一个基于 **Spring Boot + Vue.js** 前后端分离架构的教学课程资源管理平台，支持管理员、教师、学生三种角色，涵盖课程管理、教材上传审核、作业发布与提交、实时消息推送等完整教学流程。

---

## ✨ 功能特性

### 👨‍💼 管理员端
- 用户管理（教师 / 学生 / 教务管理员）
- 课程与专业管理
- 教材审核与统计分析
- 教材任务下发与完成度追踪

### 👩‍🏫 教师端
- 课程教材上传与管理
- 作业发布与批改
- 教材任务响应
- 课程反馈查看
- 资源共享

### 👨‍🎓 学生端
- 课程浏览与教材下载
- 作业查看与在线提交
- 课程反馈提交

### 🔧 系统架构
- **JWT** 无状态身份认证 + **Spring Security** 权限控制
- **Redis** 缓存加速
- **WebSocket** 实时消息推送
- **MinIO** 对象存储（文件上传）
- **MyBatis-Plus** ORM 框架
- **Knife4j** API 文档自动生成

---

## 🏗️ 技术栈

| 层级 | 技术 |
|:---:|---|
| **前端** | Vue.js 2.x · Element UI · Vuex · Vue Router · Axios · SCSS |
| **后端** | Spring Boot 2.7.3 · Spring Security · MyBatis-Plus 3.5.2 |
| **数据库** | MySQL 8.0 · Redis |
| **存储** | MinIO 8.4.3 |
| **工具** | JWT 0.9.1 · Hutool 5.8 · Fastjson 2.0 · Lombok |
| **文档** | Knife4j 3.0 (Swagger) |

---

## 📁 项目结构

```
TCRSystem/
├── backend/                    # Spring Boot 后端
│   ├── src/main/java/com/tcr/system/
│   │   ├── config/             # 配置类 (CORS, JWT, Security, WebSocket...)
│   │   ├── controller/         # REST API 控制器
│   │   │   ├── admin/          # 管理员接口
│   │   │   └── teacher/        # 教师接口
│   │   ├── dto/                # 数据传输对象
│   │   ├── entity/             # 数据库实体
│   │   ├── mapper/             # MyBatis-Plus Mapper
│   │   └── service/            # 业务逻辑层
│   └── pom.xml
├── frontend/                   # Vue.js 前端
│   ├── src/
│   │   ├── layouts/            # 页面布局 (Admin/Teacher/Student)
│   │   ├── views/              # 页面视图
│   │   │   ├── admin/          # 管理员页面
│   │   │   ├── teacher/        # 教师页面
│   │   │   └── student/        # 学生页面
│   │   ├── router/             # 路由配置
│   │   ├── store/              # Vuex 状态管理
│   │   └── utils/              # 工具函数
│   └── package.json
├── tcr_system.sql              # 数据库初始化脚本
└── README.md
```

---

## 🚀 快速开始

### 环境要求
- JDK 8+
- Node.js 14+
- MySQL 8.0
- Redis
- MinIO（可选，文件存储）

### 1️⃣ 数据库初始化

```bash
# 创建数据库
mysql -u root -p -e "CREATE DATABASE tcr_system DEFAULT CHARACTER SET utf8mb4;"

# 导入数据
mysql -u root -p tcr_system < tcr_system.sql
```

### 2️⃣ 后端启动

```bash
cd backend

# 修改数据库连接配置（如密码不是 root）
# 编辑 src/main/resources/application.yml

mvn clean install
mvn spring-boot:run
# 后端运行在 http://localhost:8080
```

### 3️⃣ 前端启动

```bash
cd frontend
npm install
npm run serve
# 前端运行在 http://localhost:3030
```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
]]>
