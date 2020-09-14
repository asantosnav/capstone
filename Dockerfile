FROM apache

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy source code to working directory
COPY index.html /var/www/html

## Step 3:
EXPOSE 80
