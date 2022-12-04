Here is the documentation that demostrate how I carried out this project;

## Project Overview
The flow will follow the same architecture below;
![design](docs/assets/designs.svg)
* [Continous Integration](#continous-integration)
  * [App Source Code](#app-source-code)
  * [Create Dockerfile](#app-source-code)
  * [Create Dockerfile](#create-dockerfile)
  * [Create and Configure Pipeline](#create-and-configure-pipeline)
  * [Check with DockerHub](#check-with-dockerhub)
* [IAC With Terraform](#iac-with-terraform)

## Hands-on
From the architecture flow shown above;
Git --> GitHub --> GitHub Actions --> Build --> Push to DockerHub --> Terraform --> AWS Resources.
## Continous Integration
A simple profile app developing with Nodejs and MongoDB & Mongo-Express for handling data persistence. I choose Docker-compose to run these services.
### App Source Code
I am using HTML and JS for the Frontend and Nodejs for the Backend, listening at port 3000. Mongo-Express make it easier for me working with MongoDB instead of using CLI, listening it at port 8081.
I created a folder ``app`` which contains static files;
1.) index.html - UI/frontend
2.) server.js - backend
3.) images folder - holding my pictures assets
NOTE; node_modules, package-lock.json and package.json is auto generated at the instance of installing nodejs.
Here is my project file structure; 
![file structure](docs/assets/file-structure.svg)

### Create Dockerfile
I will be using Docker-compose to run multiple services I intend using in this project which are MongoDB and Mongo-Express for data persistence. This will handle all my data from the app. 
From ``https://hub.docker.com`` I check the doc for right MongoDB and Mongo-Express image and its environment varibale configuration to pull for this project.

