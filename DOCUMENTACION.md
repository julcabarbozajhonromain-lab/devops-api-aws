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

### Fase 10: DevSecOps con Trivy (gate de seguridad)
- Trivy integrado en CI (fs) y CD (imagen) con aquasecurity/trivy-action
- El gate BLOQUEÓ un deploy con 14 vulnerabilidades HIGH
  (util-linux, starlette, wheel, jaraco.context)
- Remediación: apt-get upgrade en imagen base, dependencias sin pin,
  upgrade de setuptools/wheel en el builder
- Aceptación de riesgo documentada en .trivyignore (fechada y justificada)
- Política por severidad: CRITICAL bloquea; HIGH se gestiona con riesgo aceptado
- Resultado: pipeline verde con deploy automático a EC2

  ### Fase 11: Infrastructure as Code con Terraform
- Carpeta `terraform/` con 3 archivos (main.tf, variables.tf, outputs.tf)
- Recursos gestionados como código:
  - Instancia EC2 t3.micro con bootstrap automático (cloud-init)
  - Security group con puertos 22 y 8000
  - Rol IAM con política AmazonEC2ContainerRegistryReadOnly
  - Instance profile asociado a la instancia
- Flujo de trabajo: init → plan → apply
- Beneficio: infraestructura reproducible, versionada en Git,
  sin clicks manuales y con capacidad de `terraform destroy`
- Estado protegido en .gitignore (no se expone en el repo)

## 💡 Lecciones Aprendidas

### Técnicas
1. **Multi-stage builds** reducen significativamente el tamaño de imagen y mejoran seguridad
2. **Shift-left security:** detectar vulnerabilidades en CI/CD antes de producción
3. **Mínimo privilegio:** IAM con políticas específicas, nunca admin total
4. **Aceptación de riesgo:** documentar decisiones de seguridad es tan importante como la tecnología
5. **Infrastructure as Code:** próximo paso es migrar a Terraform para reproducibilidad

### Operativas
1. **Plan gratuito de AWS** limita servicios (App Runner no disponible) → evaluar alternativas
2. **Control de costos:** terminar instancias cuando no se usan (~$0.01/hora en t3.micro)
3. **Credenciales:** nunca en el código, siempre en secrets o variables de entorno
4. **Rotación de claves:** buena práctica tras cualquier exposición accidental
5. **Documentación:** README + DOCUMENTACION.md hacen el proyecto profesional y mantenible

### Profesionales
1. **Pipeline CI/CD real** vale más que 10 proyectos teóricos
2. **Troubleshooting:** cada error es una oportunidad de aprendizaje documentable
3. **Comunicación técnica:** saber explicar decisiones (ej. por qué EC2 en vez de App Runner)
4. **Iteración:** evolucionar un proyecto es más valioso que hacer muchos proyectos básicos

## 🛠️ Stack Tecnológico

### Desarrollo
- **Lenguaje:** Python 3.11
- **Framework:** FastAPI
- **Testing:** pytest
- **Contenedores:** Docker (multi-stage build)

### CI/CD
- **Plataforma:** GitHub Actions
- **Runner:** ubuntu-latest
- **Seguridad:** Trivy (escaneo de vulnerabilidades)
- **Secrets:** GitHub Secrets (cifrados)

### Cloud (AWS)
- **Compute:** EC2 (t3.micro, Amazon Linux 2023)
- **Registry:** ECR (Elastic Container Registry)
- **IAM:** Identity and Access Management
- **Región:** us-east-1 (Norte de Virginia)

### Control de Versiones
- **Git:** control de versiones distribuido
- **GitHub:** hosting de repositorio y CI/CD

## 📊 Métricas del Proyecto

| Métrica | Valor |
|---------|-------|
| Tamaño de imagen Docker | 144 MB (optimizado desde 155 MB) |
| Tiempo de CI (tests + build) | ~30 segundos |
| Tiempo de CD (build + deploy) | ~2 minutos |
| Vulnerabilidades bloqueadas | 14 HIGH |
| Tests automáticos | 3 PASSED |
| Endpoints de API | 4 |
| Fases completadas | 10 |
- **IaC:** migrar de clicks a código (Terraform) hace la infraestructura
  reproducible y auditable. Un solo `terraform apply` reconstruye todo.
## 🚀 Resultado Final

Pipeline CI/CD de extremo a extremo, 100% automático, con prácticas DevSecOps implementadas:

✅ **Integración Continua:** tests y build en cada push  
✅ **Entrega Continua:** deploy automático a producción  
✅ **Seguridad:** gate de vulnerabilidades con Trivy  
✅ **Contenerización:** Docker multi-stage optimizado  
✅ **Cloud:** despliegue en AWS EC2 con ECR  
✅ **Documentación:** README profesional + documentación técnica completa  

**URL pública:** `http://3.239.165.153:8000` (cuando la instancia está activa)

---

**Próximas mejoras planeadas:**
- Infrastructure as Code con Terraform
- Monitoreo con Prometheus + Grafana
- Kubernetes (EKS) para orquestación
- HTTPS con dominio propio y certificados SSL
