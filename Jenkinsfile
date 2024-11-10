pipeline {
    agent any

    environment {
        AZURE_VM_IP = '13.95.14.175'
        SSH_CREDENTIALS_ID = 'AppServer'  // The ID of the SSH credential you created on Jenkins
        DOCKER_IMAGE = '20058225/express'
        DOCKER_TAG = 'latest'
        DOCKERHUB_CREDENTIALS_ID = 'useradmin'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh """
                    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                    """
                }
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