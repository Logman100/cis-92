# Start with the base Python container
# FIXME: Update the version
FROM docker.io/python:3.12.3

# Install packages that are required. 
RUN pip install Django==6.0.1 psutil==7.2.2 psycopg==3.3.3

# Create a user 
RUN useradd -d /app -M django 

# Copy the Python code into the container (as the new user)
COPY --chown=django:django djangotutorial /app

# Set environment variables 
ENV STUDENT_NAME="Logan"
ENV SITE_NAME="www.cis-92.com"
ENV SECRET_KEY="fixme-12345"
ENV DEBUG=1
ENV DATA_DIR="/data"
ENV PORT=8080
ENV DJANGO_SUPERUSER_NAME="test"
ENV DJANGO_SUPERUSER_EMAIL="test@test.test"
ENV DJANGO_SUPERUSER_PASSWORD="test"
ENV POSTGRES_DB="mysite"
ENV POSTGRES_USER="mysiteuser"
ENV POSTGRES_PASSWORD="this-is-a-bad-password"
ENV POSTGRES_HOSTNAME="localhost"

# Create the data directory
RUN mkdir $DATA_DIR && chown django:django $DATA_DIR 

# Switch to the new user
USER django 

# Set the working directory
WORKDIR /app 

# Default command to execute in the container
CMD ["/bin/sh", "-c", "./start.sh"]