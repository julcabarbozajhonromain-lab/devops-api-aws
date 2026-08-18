# 📘 Documentación del Proyecto — DevOps API en AWS

Autor: Jhon Romain Julca Barboza | Sede: Cercado de Lima

## Objetivo
Implementar un pipeline CI/CD completo para una API REST en AWS.

## Fases del proyecto

### Fases 1-2: Desarrollo local
- API con Python + FastAPI (endpoints /, /health, /tasks, /docs)
- Tests con pytest (3 PASSED)

### Fase 3: Git y GitHub
- Repo público devops-api-aws, commits y push a main

### Fase 4: CI con GitHub Actions
- .github/workflows/ci.yml: pytest + docker build en cada push

### Fase 5: Docker
- Dockerfile (python 3.11-slim + uvicorn)
- Imagen devops-api:1.0, contenedor en localhost:8000

### Fase 6: AWS CLI + IAM
- Usuario devops-deployer con políticas de ECR
- Rotación de claves de acceso (buena práctica de seguridad)

### Fase 7: Amazon ECR
- Repositorio devops-api, imágenes con tag 1.0 y latest

### Fase 8: Despliegue en EC2
- Instancia t3.micro (Amazon Linux 2023), Docker + pull desde ECR
- API pública: http://3.239.165.153:8000
- Lección: App Runner no disponible en plan gratuito → pivote a EC2

### Fase 9: CD con GitHub Actions
- .github/workflows/cd.yml + 4 GitHub Secrets
- Flujo: push → build → ECR → SSH → restart del contenedor
- Verificado: cambio visible en producción en ~2 minutos

## Lecciones aprendidas
- El plan gratuito de AWS limita servicios → evaluar alternativas (EC2)
- Credenciales nunca en el código: usar IAM + GitHub Secrets + rotación
- Control de costos: terminar instancias y configurar presupuestos

## Resultado final
Pipeline CI/CD de extremo a extremo, 100% automático.
