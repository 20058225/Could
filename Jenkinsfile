pipeline {
    agent any

    environment {
        AZURE_VM_IP = '13.95.14.175'
        SSH_CREDENTIALS_ID = 'AppServer'  // Jenkins SSH credentials ID for Azure VM
        DOCKER_CREDS = credentials('dockerhub-credentials')  // DockerHub credentials in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Pull code from the SCM repository
            }
        }   
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t 20058225/express:latest .'  // Build Docker image
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', 
                                                usernameVariable: 'DOCKER_USER', 
                                                passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        set +x
                        echo "\${DOCKER_PASS}" | docker login -u "\${DOCKER_USER}" --password-stdin || exit 1
                        set -x
                        docker push 20058225/express:latest
                        docker logout
                    """
                }
            }
        }
        stage('Deploy to Azure VM') {
            steps {
                script {
                    sshagent(['AppServer']) {  // Use SSH credentials to connect to the VM
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