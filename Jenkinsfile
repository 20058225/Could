pipeline {
    agent any

    environment {
        AZURE_VM_IP = '13.95.14.175'
        SSH_CREDENTIALS_ID = 'AppServer'  // The ID of the SSH credential you created
        DOCKER_IMAGE = 'express'
        DOCKER_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                checkout scm
            }
        }      
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }
        stage('Deploy to Azure VM') {
            steps {
                script {
                    // Use SSH to connect to the Azure VM and run Docker commands to pull and run the container
                    sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                        sh """
                        ssh -o StrictHostKeyChecking=no useradmin@${AZURE_VM_IP} << EOF
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG} || true
                        docker stop express || true
                        docker rm express || true
                        docker run -d --name express -p 3000:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                        EOF
                        """
                    }
                }
            }
        }
    }
}