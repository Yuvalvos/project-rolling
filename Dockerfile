# 1. Base Image
FROM python:3.10-slim

# 2. Working Directory
WORKDIR /app

# 3. Copy Requirements
COPY python/requirements.txt .

# 4. Install Dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy Source Code
COPY python/ .

# 6. Expose Port
EXPOSE 5001

# 7. Start Command
CMD ["python", "app.py"]