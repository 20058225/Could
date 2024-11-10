pipeline {
    agent any
    environment {
        REMOTE_HOST = 'useradmin@13.95.14.175'
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-credentials'  // ID for DockerHub credentials
        SSH_CREDENTIALS_ID = 'AppServer'  // SSH credentials for remote access
        DOCKER_IMAGE = '20058225/express'
        DOCKER_TAG = 'latest'
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
        stage('Pull Docker Image on Remote') {
            steps {
                sshagent(['AppServer']) {  // Use 'AppServer' for SSH access to the remote client
                    sh """
                        ssh $REMOTE_HOST '
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD &&
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG} &&
                        docker logout
                        '
                    """
                }
            }
        }
        stage('Run Docker Container on Remote') {
            steps {
                sshagent(['AppServer']) {  
                    sh """
                        ssh $REMOTE_HOST '
                        docker stop express || true &&
                        docker rm express || true &&
                        docker run -d --name express --memory=512m --cpus=0.5 -p 3000:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                        '
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'CI/CD pipeline completed.'
        }
    }
}