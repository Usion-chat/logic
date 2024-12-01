# Use an official Node.js LTS (Long Term Support) version as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY src/frontend/package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the rest of the frontend source code to the container
COPY src/frontend/ .

# Expose port 3000 to the host machine
EXPOSE 3000

# Start the frontend application in development mode
CMD ["npm", "start"]
