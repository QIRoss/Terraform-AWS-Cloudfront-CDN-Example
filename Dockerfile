FROM python:3.9-slim

WORKDIR /app
COPY . /app
RUN pip install fastapi uvicorn

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]
