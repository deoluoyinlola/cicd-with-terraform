Here is the documentation that demostrate how I carried out this project;

## Project Overview
The flow will follow the same architecture below;
![design](docs/assets/designs.svg)
* [Continous Integration](#continous-integration)
  * [App Source Code](#app-source-code)
  * [Multiple Services with Docker-compose](#multiple-services-with-docker-compose)
  * [Build Image with Dockerfile](#build-image-with-dockerfile)
  * [Pipeline with GitHub Actions](#pipeline-with-github-aactions)
  * [Check with DockerHub](#check-with-dockerhub)
* [IAC With Terraform](#iac-with-terraform)
  * [Authenticate to Provider(AWS)](#authenticate-to-provider)
  * [Provisioning Basic Infrastrucure](#provisioning-basic-infrastrucure)
  * [Creating EC2 Instance](#Creating-ec2-instance)
  


## Hands-on
From the architecture flow shown above;
Git --> GitHub --> GitHub Actions --> Build --> Push to DockerHub --> Terraform --> AWS Resources.
## Continous Integration
A simple wait list app developing with html, css and js. While build the Docker image with GitHub Actions and get push to DockerHub.
Here is the project file structure; 
![file structure](assets/file-structure.png)

### App Source Code
I am using HTML and JS for the Frontend and Nodejs for the Backend, listening at port 3000. Mongo-Express make it easier for me working with MongoDB instead of using CLI, listening it at port 8081.
I created a folder ``app`` which contains static files;
1.) index.html - UI/frontend
2.) server.js - backend
3.) images folder - holding my pictures assets
NOTE; node_modules, package-lock.json and package.json are auto generated at the instance of installing npm for dependencies. While docker-compose.yaml is created at docker-compose session and .dockerignore created to basically ignore node_modules been commited to remote repo.

### Multiple Services with Docker-compose
I will be using Docker-compose to run this app and other third-party(MongoDB and Mongo-Express for data persistence) services. From ``https://hub.docker.com`` I checked the doc for the right use of MongoDB and Mongo-Express image and its environment varibale configuration. The resulting configuration for the yaml file is saved with named ``docker-compose.yaml`` as part of application code.
NOTE; In production scale, all the environment variable need to be well secured, and defined externally not as I expose it here.

### Build Image with Dockerfile
Here, I define Dockerfile as the blueprint for building the image, which contain a copy of the application source code and its dependencies. Following is what I expected if I start a container from this image; I based the image on ``node:13-alpine`` image so all execution follow Linux command, define env internally, create a /home/app directory, from the host machine copy the current folder files to /home/app, I then start the app with ``node server.js`` - the entrypoint command. I commited this file to my remote repo at the root as can be seen from the file structure.

### Pipeline with GitHub Actions


## IAC With Terraform
The architecture flow will be like this;
Create VPC --> Subnet --> Route Tables & Internet Gateway --> EC2 --> Deploy Docker container --> Security Group

### Authenticate to Provider(AWS)
- I created a file named ``main.tf`` which contain all the terraform configuration for this project.
- Using the I AM user role credentials created from AWS, terraform authenticate into AWS and authorize to provision the above infrastructures.
- Remote backend; To use remote backend, I first ``terraform init`` and ``terraform apply`` inside the folder for local backend afterwhich I then rerun with remote backend. Below is my first lines of defination inside the `main.tf` file;
![tf-first](assets/tf-first.png)
Then initialise with `terraform init` and `terraform apply`;
![tf-init](assets/tf-init.png)
Switched to remote backend after adding the same to the file with `terraform init` and `terraform apply`;
![tf-remote](assets/tf-remote.png)
Both S3 and DynamoDb table created, serving as container for storing remote backend; 
![tf-s3](assets/tf-s3.png)
![tf-dyno](assets/tf-dyno.png)

### Provisioning Basic Infrastrucure
- Worth of note that terraform is smart enough to create componemt accrodingly even when the defination is out of order/sequence.
- Variable; I set separate list of variables for AZ as a set, name tag for every component created I give it a prefix of environment that will be deploy in(using variable inside string).
- Trying to check if this config working, first deploy VPC and subnet;
![vpc](assets/vpc.png)
And the subnet;
![subnet](assets/subnet.png)
- Created route table, Subnet association with route table.
- Security group; I configure firewall rules of the EC2 instance, where I just expose port 22 for ssh, tcp at 8080 and outbound rule at any.

### Creating EC2 Instance
- I choose Amazon Machine Image of Linux distribution, dynamically using its AMI ID value in the desire region all defined in the data block, check image below;
![ami-data](assets/ami-data.png)
When checked to know if it same with desire AMI, output on the terminal before actual deployment;
![ami-check](assets/ami-check.png)


variable instance_type {}
variable ssh_key {}











resource "aws_key_pair" "ssh-key" {
  key_name   = "myapp-key"
  public_key = file(var.ssh_key)
}

output "server-ip" {
    value = aws_instance.myapp-server.public_ip
}


resource "aws_instance" "myapp-server-two" {
  ami                         = data.aws_ami.amazon-linux-image.id
  instance_type               = var.instance_type
  key_name                    = "myapp-key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.myapp-sg.id]
  availability_zone			      = var.avail_zone

  tags = {
    Name = "${var.env_prefix}-server-two"
  }

  user_data = <<EOF
                 #!/bin/bash
                 apt-get update && apt-get install -y docker-ce
                 systemctl start docker
                 usermod -aG docker ec2-user
                 docker run -p 8080:8080 nginx
              EOF
}