# Start from a Node js 16 (LTS )
FROM node:20

# Specify the directory inside the image in which all command will run

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install 
RUN npm install express


#Copy all the app file into the image
COPY . .


# the default command to run when starting the container
CMD [ "npm","start" ]
