# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN python3 -m pip install --upgrade pip && python3 -m pip install -r requirements.txt

# Install New Relic
RUN python3 -m pip install newrelic

# Copy the current directory contents into the container at /app
COPY . /app/

# Expose the port the app runs on
EXPOSE 8000

# Set the New Relic config file environment variable
ENV NEW_RELIC_CONFIG_FILE=/app/newrelic.ini

# Run the Django application using New Relic
CMD ["newrelic-admin", "run-program", "python3", "manage.py", "runserver", "0.0.0.0:8000"]

