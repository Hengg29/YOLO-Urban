FROM python:3.10-slim

# Evitar prompts interactivos en apt y mejorar salida de Python/pip
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Dependencias de sistema para OpenCV / Ultralytics
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

# Directorio de trabajo
WORKDIR /app

# Copiar requirements primero para aprovechar la cache de Docker
COPY requirements.txt /app/requirements.txt

# Instalar dependencias de Python
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt

# Copiar el resto del proyecto
COPY . /app

# Puerto interno de Streamlit
EXPOSE 8501

# Comando de arranque
# Usa $PORT si tu plataforma de hosting lo define (Cloud Run, Render, Railway, etc.)
CMD ["sh", "-c", "streamlit run Siu.py --server.port=${PORT:-8501} --server.address=0.0.0.0"]
