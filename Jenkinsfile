pipeline {
    agent any
    environment {
        REMOTE_HOST = 'useradmin@13.95.14.175'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Retrieve Docker Credentials') {
            steps {
                script {
                    env.DOCKER_CREDS = sh(script: 'pass show docker-credentials', returnStdout: true).trim()
                }
            }
        }
        stage('Build Docker Image on Remote') {
            steps {
                sshagent(['AppServer']) {  // Use 'AppServer' for SSH access to the remote client
                    sh """
                        ssh $REMOTE_HOST 'docker build -t 20058225/express:latest /path/to/app/on/remote'
                    """
                }
            }
        }
        stage('Push Docker Image from Remote') {
            steps {
                sshagent(['AppServer']) {  
                    sh """
                        ssh $REMOTE_HOST '
                            echo "$DOCKER_CREDS" | docker login -u "your-docker-username" --password-stdin &&
                            docker push 20058225/express:latest &&
                            docker logout
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
