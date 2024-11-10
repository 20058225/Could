pipeline {
    agent any

    environment {
        AZURE_VM_IP = '13.95.14.175'
        SSH_CREDENTIALS_ID = 'AppServer'  // The ID of the SSH credential you created on Jenkins
        DOCKER_CREDS = credentials('dockerhub-credentials')
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
                    sh 'docker build -t 20058225/express:latest .'
                }
            }
        }
        stage('Deploy to Azure VM') {
            steps {
                script {
                    sshagent('AppServer') {
                        sh """
                        ssh -o StrictHostKeyChecking=no useradmin@13.95.14.175 << EOF
                        docker pull 20058225/express:latest || true
                        docker stop express || true
                        docker rm express || true
                        docker run -d --name express --memory=512m --cpus=0.5 -p 3000:3000 20058225/express:latest
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