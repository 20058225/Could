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
        stage('Build Docker Image on Remote') {
            steps {
                sshagent(['AppServer']) {  // Use 'AppServer' for SSH access to the remote client
                    sh """
                        ssh $REMOTE_HOST 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} /home/useradmin'
                    """
                }
            }
        }
        stage('Push Docker Image from Remote') {
            steps {
                sshagent(['AppServer']) {  
                    withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh """
                            ssh $REMOTE_HOST '
                                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin &&
                                docker push ${DOCKER_IMAGE}:${DOCKER_TAG} &&
                                docker logout
                            '
                        """
                    }
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