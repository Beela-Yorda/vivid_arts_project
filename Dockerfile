FROM python:3.9-slim-buster
WORKDIR /app

# Copy requirements first for caching
COPY ./requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the rest of the application
COPY . /app/

# Expose port 8000
EXPOSE 8000

# Install gunicorn
RUN pip install gunicorn

# Set environment variables
ENV FLASK_APP=app.py

# Start gunicorn server
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]