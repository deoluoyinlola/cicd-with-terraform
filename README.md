## Description
Deploy JS app to virtual machine from GitHub Action, while I use Terraform to provision AWS resources. Similar projects where I use GitLab CI and CloudFormation can be find here; https://gitlab.com/cicd-group-projects/gitlab-with-cloudformation
![design](docs/assets/designs.svg)

## Wanna Try it Out on your Local Machine

This app shows a simple user profile app set up using 
- index.html with pure js and css styles
- nodejs backend with express module
- mongodb for data storage

All components are docker-based
Yu can as well try it out locally on your machine without Docker, the choice is yours but I am going to explain how to with Docker;
### With Docker

#### To start the application

Step 1: Create docker network

    docker network create mongo-network 

Step 2: start mongodb 

    docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name mongodb --net mongo-network mongo    

Step 3: start mongo-express
    
    docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=password --net mongo-network --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express   

_NOTE: creating docker-network in optional. You can start both containers in a default network. In this case, just emit `--net` flag in `docker run` command_

Step 4: open mongo-express from browser

    http://localhost:8081

Step 5: create `user-account` _db_ and `users` _collection_ in mongo-express

Step 6: Start your nodejs application locally - go to `app` directory of project 

    cd app
    npm install 
    node server.js
    
Step 7: Access you nodejs application UI from browser

    http://localhost:3000

### With Docker Compose

#### To start the application

Step 1: start mongodb and mongo-express

    docker-compose -f docker-compose.yaml up
    
_You can access the mongo-express under localhost:8080 from your browser_
    
Step 2: in mongo-express UI - create a new database "my-db"

Step 3: in mongo-express UI - create a new collection "users" in the database "my-db"       
    
Step 4: start node server 

    cd app
    npm install
    node server.js
    
Step 5: access the nodejs application from browser 

    http://localhost:3000

#### To build a docker image from the application

    docker build -t my-app:1.0 .       
    
The dot "." at the end of the command denotes location of the Dockerfile.


## Documentation
To better understand this project, I am documenting every steps, project code and every command line arguments that I used in completing this project. For this, I have created a separate README file inside the docs directory at the root directory for this project, the directory also holds some of the project assets(images and pictures)

## Useful tools
- [aws](https://aws.amazon.com/) - cloud platform, offering over 200 fully featured services from data centers globally.
- [VSCode](https://code.visualstudio.com/) - preferred IDE 
- [Docker](https://wwww.docker.com/) - to build the image and push the app
- [terraform](https://www.terraform.io/) - the main iac tool

## Lesson learnt
