pipeline {
    agent any

    environment {
        AZURE_VM_IP = '13.95.14.175'
        SSH_CREDENTIALS_ID = 'AppServer'  // The ID of the SSH credential you created on Jenkins
        DOCKER_IMAGE = 'express'
        DOCKER_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }      
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }
        stage('Deploy to Azure VM') {
            steps {
                script {
                    // Use SSH to connect to the Azure VM and run Docker commands to pull and run the container
                    sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                        echo "${SSH_CREDENTIALS_ID}"
                        echo "${DOCKER_IMAGE}"
                        echo "${DOCKER_TAG}"
                        echo "${AZURE_VM_IP}"
                        sh """
                        ssh -o StrictHostKeyChecking=no useradmin@${AZURE_VM_IP} << EOF
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG} || true
                        docker stop express || true
                        docker rm express || true
                        docker run -d --name express --memory=512m --cpus=0.5 -p 3000:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                        EOF
                        """
                    }
                }
            }
        }
    }
    post {
        always {
            echo "CI/CD pipeline completed."
        }
    }
}