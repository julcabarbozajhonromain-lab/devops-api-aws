from fastapi import FastAPI

app = FastAPI(
    title="API DevOps",
    description="Mi primera API con despliegue automático en AWS",
    version="1.0.0"
)

@app.get("/")
def read_root():
    return {
        "mensaje": "¡Hola desde mi API DevOps!",
        "autor": "Jhon Julca",
        "estado": "funcionando correctamente - deploy automatico"
    }

@app.get("/health")
def health_check():
    return {"status": "healthy", "servicio": "api-devops"}

tasks = [
    {"id": 1, "title": "Aprender Git", "done": True},
    {"id": 2, "title": "Aprender Docker", "done": False},
    {"id": 3, "title": "Desplegar en AWS", "done": False}
]

@app.get("/tasks")
def get_tasks():
    return {"tasks": tasks, "total": len(tasks)}