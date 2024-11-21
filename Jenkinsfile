pipeline {
    agent any
    environment {
        AZURE_VM_IP = '52.232.44.180'
        SSH_CREDENTIALS_ID = 'AppServer'  // SSH credentials for remote access
        DOCKER_IMAGE = 'express'
        DOCKER_TAG = 'latest'
        AZURE_USER = 'useradmin'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Buil Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }   
        stage('Save Docker Image') {
            steps {
                sh "docker save -o ${DOCKER_IMAGE}.tar ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
        stage('Copy to Azure VM') {
            steps {
                sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                    sh """
                    scp ${DOCKER_IMAGE}.tar ${AZURE_USER}@${AZURE_VM_IP}:/tmp/
                    """
                }
            }
        }
        stage('Deploy to Azure VM') {
            steps {
                sshagent(credentials: ["${SSH_CREDENTIALS_ID}"]) {
                    script {
                        try {
                            sh """
                            ssh ${AZURE_USER}@${AZURE_VM_IP} << 'EOF'
                            docker load < /tmp/${DOCKER_IMAGE}.tar
                            docker run -d --name express-app-container -p 80:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                            EOF
                            """
                        } catch (Exception e) {
                            echo "Ignoring non-critical error: ${e.getMessage()}"
                        }
                    }
                }
            }
        }
    }
}
