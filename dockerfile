# Build Stage
FROM node:23

WORKDIR /usr/src/app
COPY package*.json ./

RUN npm install 

# Copy source files after installing dependencies
COPY server.js ./

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
