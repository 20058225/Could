## Docker commands
  # Check version
    docker --version
  # Check dockers running
    docker ps
  # Check all dockers
    docker ps -a
  # Check logs name_docker
  

# Create a new dockerfile with a name/door and specific version
  docker run --name insert_a_name -d -p insert_door:door image:version
    # Docker for nginx
      docker run --name web-app -d -p 9000:80 nginx:1.27

# Create a new
FROM node:23-alpine       #Downloading a version

COPY package.json /app/   #Copying the specific file
COPY src /app/            #Copying all file 

WORKDIR /app              #Install all pkg 
RUN npm install           #Install npm

CMD [ "node", "server.js"] 

# Building --
cd/docker
docker build -t node-app:1.0 .

# Run and check Docker 
docker run -d -p 3000:3000 node-app:1.0