pipeline{
	agent any
	options {
		disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))		
	}

	stages {
		stage('Checkout SCM Code') {
			steps {
				// Used dummy git URL and values for demo purposes
				git credentialsId: 'git-credentials-id-from-Jenkins', url: 'https://github.com/your-username/your-private-repo.git', branch: "${BRANCH_NAME}" 
			} 
		} // end stage
		stage('Code Compile') {
			steps {
				// Configure Maven
                tools {
                    maven 'Maven-3.8.3' // Use specific Maven installation configured in Jenkins
                }
				sh 'mvn clean compile'
			} 
		} // end stage
		stage('Run Tests') {
			steps {
                tools {
                    maven 'Maven-3.8.3' // Use specific Maven installation configured in Jenkins
                }
				sh 'mvn test'
			} 
            post {
                always { // recording test cases results
                    junit '**/surefire-reports/**/*.xml'  
                }
            } 
		} // end stage
		stage('Build Docker Image') {
			steps {
				sh "docker build -t ${DOCKER_IMAGE_NAME}:${VERSION} ." // Assuming DOCKER_IMAGE_NAME as spring-petclinic and VERSION as 1.0
			} 
		} // end stage
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'artifactory-credentials', usernameVariable: 'ARTIFACTORY_USERNAME', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                    // Used my JFrog Artifactory Docker registry Trail account URL for demo purposes
                    sh "docker login -u ${ARTIFACTORY_USERNAME} -p ${ARTIFACTORY_PASSWORD} saimeduri.jfrog.io"
                }
            }
        }
		stage('Push app Image to JFrog repository') {
			steps {
				sh "docker tag ${DOCKER_IMAGE_NAME}:${VERSION} saimeduri.jfrog.io/docker-trial/${DOCKER_IMAGE_NAME}:${VERSION}"
				sh "docker push saimeduri.jfrog.io/docker-trial/${DOCKER_IMAGE_NAME}:${VERSION}"
				} 
		} // end stage
		stage('Cleaning Workspace') {
			steps {
				sh "docker rm -f ${DOCKER_IMAGE_NAME}:${VERSION} || exit 1;"
				echo 'Finished and deleting workspace'
				deleteDir()
			} 
		} // end stage
	} // end stages
} // end pipeline