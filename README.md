# TCRSystem — TCR 免疫组库序列分析系统

[![Python](https://img.shields.io/badge/Python-3.8+-3776AB?logo=python&logoColor=white)](https://python.org/)
[![Django](https://img.shields.io/badge/Django-4.x-092E20?logo=django)](https://djangoproject.com/)
[![Vue.js](https://img.shields.io/badge/Vue.js-3.x-4FC08D?logo=vue.js)](https://vuejs.org/)
[![License](https://img.shields.io/badge/License-MIT-blue)](LICENSE)

## 项目背景

T 细胞受体（TCR）是免疫系统识别抗原的核心分子。在肿瘤免疫治疗、传染病研究、自身免疫疾病等领域，研究人员需要分析大量 TCR 测序数据来了解免疫应答状态。然而现有的 TCR 分析工具大多基于命令行，操作门槛高，可视化能力弱，不利于临床和科研人员快速获取分析结果。

本项目构建了一个基于 Web 的 TCR 序列分析平台，提供从数据上传、序列比对、克隆型统计到可视化报告的一站式分析流程。

## 效果展示

### 系统主界面
![系统主界面](docs/dashboard.png)

支持 TCR 序列数据的上传、在线分析和结果导出，数据表格展示 CDR3 序列、V/J 基因使用、频率等关键信息。

### 分析报告
![分析报告](docs/analysis-report.png)

自动生成 V-J 基因配对热图、CDR3 长度分布、克隆型频率排序等免疫组库分析图表。

## 核心功能

| 功能 | 说明 |
|------|------|
| 数据上传 | 支持 FASTA、TSV 等格式的 TCR 测序数据 |
| 序列分析 | CDR3 区域提取、V/J 基因注释、克隆型识别 |
| 统计分析 | 多样性指数计算、基因使用频率统计 |
| 可视化 | V-J 配对热图、长度分布、丰度排序等图表 |
| 报告导出 | 一键生成 PDF/Excel 格式分析报告 |

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端 | Vue.js 3 + Element Plus + ECharts |
| 后端 | Django + Django REST Framework |
| 分析引擎 | Python（BioPython、pandas、scikit-learn） |
| 数据库 | MySQL |
| 部署 | Nginx + Gunicorn |

## 项目结构

```
TCRSystem/
├── backend/                    # Django 后端
│   ├── apps/
│   │   ├── analysis/           # 分析模块
│   │   ├── users/              # 用户管理
│   │   └── reports/            # 报告生成
│   ├── config/                 # 配置
│   ├── manage.py
│   └── requirements.txt
├── frontend/                   # Vue.js 前端
│   ├── src/
│   │   ├── views/              # 页面组件
│   │   ├── components/         # 通用组件
│   │   └── api/                # API 封装
│   └── package.json
└── README.md
```

## 快速开始

```bash
# 后端
cd backend
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver

# 前端
cd frontend
npm install
npm run dev
```

## 开源协议

MIT License
