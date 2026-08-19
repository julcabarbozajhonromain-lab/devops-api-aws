# ==========================================================
# STAGE 1: builder - instala dependencias
# ==========================================================
FROM python:3.11-slim AS builder

WORKDIR /build

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt \
    && pip install --no-cache-dir --prefix=/install --upgrade pip setuptools wheel

# ==========================================================
# STAGE 2: runtime - imagen minima de produccion
# ==========================================================
FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local

COPY app/ .

RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]