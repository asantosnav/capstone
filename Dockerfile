FROM nginx:alpine


## Step 1:
# Copy source code to working directory
COPY index.html /usr/share/nginx/html

## Step 2:
EXPOSE 80
