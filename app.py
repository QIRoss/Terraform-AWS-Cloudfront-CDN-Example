from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, world from FastAPI!"}

@app.get("/dynamic")
def dynamic_content():
    return {"message": "This is dynamic content served via CloudFront!"}
