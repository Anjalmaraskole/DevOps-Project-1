# ✅ Correct Python base image
FROM python:3.12-slim

# ✅ Working directory set
WORKDIR /app

# ✅ Copy requirements.txt and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# ✅ Copy full project code into /app
COPY . .

# ✅ Expose Django default port
EXPOSE 8000

# ✅ Run Django server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

