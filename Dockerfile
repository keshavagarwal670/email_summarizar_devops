# Dockerfile for web service
FROM python:3.8

# Install MySQL client tools
RUN apt-get update && apt-get install -y default-mysql-client

WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application directory
COPY . .

# Copy the wait-for-db.sh script
COPY wait-for-db.sh /app/

# Set executable permissions for wait-for-db.sh
RUN chmod +x wait-for-db.sh

# Command to run the application
CMD ["./wait-for-db.sh", "db", "3306", "python", "run.py"]
