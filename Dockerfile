FROM python:3.10-slim

# Evitar bloquear instalación por i/o
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema necesarias para OpenCV y Ultralytics
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libgoogle-glog0v5 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de la app
WORKDIR /app

# Copiar requirements
COPY requirements.txt .

# Instalar Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto del proyecto
COPY . .

# Puerto de Streamlit
EXPOSE 8501

# Comando de ejecución
CMD ["streamlit", "run", "Siu.py", "--server.port=8501", "--server.address=0.0.0.0"]
