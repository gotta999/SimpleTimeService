# Use the smallest possible Python image
FROM python:3.9-slim

# Set a non-root user
RUN useradd -m appuser
USER appuser

# Set the working directory inside the container
WORKDIR /app

# Copy the application files
COPY app.py .

# Expose the port
EXPOSE 8080

# Run the application
CMD ["python3", "app.py"]
