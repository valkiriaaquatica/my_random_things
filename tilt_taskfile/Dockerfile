FROM ubuntu:22.04
RUN apt update -y && \
    apt install -y python3 python3-pip && \
    apt clean && \
    pip install --no-cache-dir pylint pytest

WORKDIR /app
ENV PYTHONPATH=/app
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir 
COPY . .
ENV FLASK_APP=server.py
CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000", "--reload"]
