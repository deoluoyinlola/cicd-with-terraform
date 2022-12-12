
# Contents
* [Description](#Description)
* [Architecture](#Architecture)
* [Project Requirement](#Project-requirement)
* [Tools Used](#Tools-used)
* [Project Deliverables](#Project-deliverables)
* [Documentation](#Documentation)
* [Lesson learnt](#Lesson-learnt)

## Description
Deploy JS app to virtual machine from GitHub Action, while I use Terraform to provision AWS resources. Similar projects where I use GitLab CI and CloudFormation can be find here; https://gitlab.com/cicd-group-projects/gitlab-with-cloudformation

## Architecture
![design](docs/assets/designs.svg)

## Project Requirement
- Accessible to over 500 users publicly
- A simple waiting list app
- Monolith with two-tiers

## Tools Used
- [aws](https://aws.amazon.com/) - cloud platform, offering over 200 fully featured services from data centers globally.
- [VSCode](https://code.visualstudio.com/) - preferred IDE 
- [Docker](https://wwww.docker.com/) - to build the image and push the app
- [terraform](https://www.terraform.io/) - the main iac tool
- [nginx](https://www.nginx.com/) - open source web server that can also be used as a reverse proxy, load balancer.


## Project Deliverables
![d-app](docs/assets/d-app.png)
A simple wait list app developing with html, css, js and serve with Nginx.

#### To start the application on your local machine
- Fork or clone the repo;
- cd into the directory;
- Open the webpage with ``google-chrome index.html``
    
## Documentation
To better understand this project, I am documenting every steps, project code and every command line arguments that I used in completing this project. For this, I have created a separate README file inside the docs directory at the root directory for this project, the directory also holds some of the project assets(images and pictures)

## Lesson learnt
- You can never be wrong with vendor documentation.
- Stackoverflow is life saving, need be good with it.