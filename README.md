# 🚀 DevOps API — FastAPI + Docker + AWS (CI/CD completo)

API REST con pipeline de integración y entrega continua desplegada en AWS.

## 🏗️ Arquitectura
Código → GitHub → CI (tests) → Docker → ECR → CD (SSH) → EC2 → Internet

## 🛠️ Stack
- **Backend:** Python 3.11 + FastAPI
- **Contenedores:** Docker + Amazon ECR
- **CI/CD:** GitHub Actions
- **Nube:** AWS (IAM, ECR, EC2)

## 🔌 Endpoints
- `GET /` → bienvenida
- `GET /health` → salud del servicio
- `GET /tasks` → datos de ejemplo
- `/docs` → documentación Swagger interactiva

## ✅ Pipeline
- **CI:** pytest + build Docker en cada push
- **CD:** build → push a ECR → deploy SSH a EC2 automático

## 👤 Autor
Jhon Romain Julca Barboza — Proyecto de aprendizaje DevOps
