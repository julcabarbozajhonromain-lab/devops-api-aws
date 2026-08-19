# ==========================================================
# STAGE 1: builder - instala dependencias
# ==========================================================
FROM python:3.11-slim AS builder

WORKDIR /build

COPY app/requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ==========================================================
# STAGE 2: runtime - imagen minima de produccion
# ==========================================================
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /install /usr/local

COPY app/ .

RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]