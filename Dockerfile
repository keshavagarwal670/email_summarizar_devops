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


# # Use the official Python image as a base image
# FROM python:3.8

# # Set the working directory in the container
# WORKDIR /app

# # Copy the requirements file into the container at /app
# COPY requirements.txt /app/

# # Install dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the rest of the application code into the container at /app
# COPY . /app/

# # Expose port 5000 to the outside world
# EXPOSE 5000

# # Command to run the application
# CMD ["python", "run.py"]
