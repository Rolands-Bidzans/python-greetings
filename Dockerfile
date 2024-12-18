FROM python:3-alpine
LABEL DESCRIPTION="Dockerfile for greeting app backend service"

# Set the working directory in the container
WORKDIR /app

# Copy the files
COPY requirements.txt .
COPY app.py .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port
EXPOSE 3000

CMD [ "app.py" ]
ENTRYPOINT [ "python" ]
