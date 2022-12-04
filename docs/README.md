Here is the documentation that demostrate how I carried out this project;

## Project Overview
The flow will follow the same architecture below;
![design](docs/assets/designs.svg)
* [Continous Integration](#continous-integration)
  * [App Source Code](#app-source-code)
  * [Multiple Services with Docker-compose](#multiple-services-with-docker-compose)
  * [Build Image with Dockerfile](#build-image-with-dockerfile)
  * [Create and Configure Pipeline](#create-and-configure-pipeline)
  * [Check with DockerHub](#check-with-dockerhub)
* [IAC With Terraform](#iac-with-terraform)

## Hands-on
From the architecture flow shown above;
Git --> GitHub --> GitHub Actions --> Build --> Push to DockerHub --> Terraform --> AWS Resources.
## Continous Integration
A simple profile app developing with Nodejs and MongoDB & Mongo-Express for handling data persistence. I choose Docker-compose to run these services, while build the image with GitHub Actions and get push to DockerHub.
Here is the project file structure; 
![file structure](docs/assets/file-structure.png)

### App Source Code
I am using HTML and JS for the Frontend and Nodejs for the Backend, listening at port 3000. Mongo-Express make it easier for me working with MongoDB instead of using CLI, listening it at port 8081.
I created a folder ``app`` which contains static files;
1.) index.html - UI/frontend
2.) server.js - backend
3.) images folder - holding my pictures assets
NOTE; node_modules, package-lock.json and package.json is auto generated at the instance of installing nodejs.

### Multiple Services with Docker-compose
I will be using Docker-compose to run this app and other third-party(MongoDB and Mongo-Express for data persistence) services. From ``https://hub.docker.com`` I checked the doc for the right use of MongoDB and Mongo-Express image and its environment varibale configuration. The resulting configuration for the yaml file is saved with named ``docker-compose.yaml`` as part of application code in the root of the folder.
NOTE; In production scale, all the environment variable need to be well secured not as I expose it here.

### Build Image with Dockerfile
I will be using Docker-compose to run multiple services I intend using in this project which are MongoDB and Mongo-Express for data persistence. This will handle all my data from the app. 
From ``https://hub.docker.com`` I check the doc for right MongoDB and Mongo-Express image and its environment varibale configuration to pull for this project.

## IAC With Terraform