# Spring PetClinic Project

This project is a fork of the Spring PetClinic application (https://github.com/spring-projects/spring-petclinic), a sample application for managing a pet clinic. In this fork, we've added a Jenkins pipeline for building, testing, and deploying the application as a Docker container.

## Prerequisites

Before running the project, ensure you have the following prerequisites installed:

- Docker: For building and running Docker containers. Install Docker from [Docker's official website](https://www.docker.com/get-started).
- Java Development Kit (JDK): For compiling and running the Java code. Install the JDK from [Oracle's website](https://www.oracle.com/java/technologies/javase-downloads.html) or any other distribution.
- Maven: For building the Java project. You can install Maven by following the instructions on [Maven's official website](https://maven.apache.org/download.cgi).

## Building and Running the Project

Follow these steps to build and run the project:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/saimeduri/jf-assignment-petclinic-app.git

2. **Navigate to the Project Directory:**
   
   ```bash
   cd spring-petclinic

3. **Build the Project with Maven:**
   
   ```bash
   mvn clean package -DskipTests

4. **Build the Docker Image:**
   
   ```bash
   docker build -t spring-petclinic:1.0 .

5. **Run the Docker Container:**

   ```bash
   docker run -itd -p 8080:8080 spring-petclinic:1.0

6. **Access the Application:**
Open a web browser and navigate to http://localhost:8080 to access the Spring PetClinic application.

## Jenkins Pipeline

This project includes a Jenkins pipeline defined in the Jenkinsfile. The pipeline consists of the following stages:
1. Code Compile: Compiles the code using Maven.
2. Run Tests: Runs tests using Maven and records the test results using JUnit.
3. Build Docker Image: Builds a Docker image based on the provided Dockerfile.
4. Push app Image to JFrog repository: Uploads the built Docker image to a JFrog repository using JFrog CLI.
5. Cleaning Workspace: Cleans up by removing the Docker container and workspace.

To run the Jenkins pipeline:
- Ensure you have Jenkins installed and configured in your environment.
- Create a new Jenkins pipeline job and point it to this repository.
- Configure the Jenkins job to use the Jenkinsfile provided in this repository.
- Run the Jenkins job to execute the pipeline stages.

## Commands to push the Docker Image to JFrog artifactory

1. **Tag the previously built Docker Image with JFrog artifactory naming convention:**

   ```bash
   docker tag spring-petclinic:1.0 saimeduri.jfrog.io/docker-trial/spring-petclinic:1.0

2. **Docker login to JFrog artifactory:**
Please refer to JFrog documentation to setup Docker artifactory: https://jfrog.com/help/r/jfrog-artifactory-documentation/set-up-a-docker-repository

   ```bash
   docker login -u ${ARTIFACTORY_USERNAME} -p ${ARTIFACTORY_PASSWORD} ${JFROG_URL}

3. **Image push to JFrog artifactory:**

   ```bash
   docker push saimeduri.jfrog.io/docker-trial/spring-petclinic:1.0

## Commands to pull existing image and run the container from JFrog artifactory

1. **Docker image pull from JFrog artifactory:**

   ```bash
   docker pull saimeduri.jfrog.io/docker-trial/spring-petclinic:2.0

2. **Load the Docker image from the shared tarball**

   ```bash
   docker load -i spring-petclinic.tar

3. **Running the container:**

   ```bash
   docker run -itd -p 8080:8080 saimeduri.jfrog.io/docker-trial/spring-petclinic:2.0

4. **Access the Application:**

Open a web browser and navigate to http://localhost:8080 to access the application.
