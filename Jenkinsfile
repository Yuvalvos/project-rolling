pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        AWS_ACCESS_KEY_ID      = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY  = credentials('aws-secret-key')
        
        DOCKER_USER = 'yuvalv1288'
        IMAGE_NAME  = 'project-rolling-app'
        REPO_URL    = 'https://github.com/Yuvalvos/project-rolling.git'
    }
    
    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main', url: "${REPO_URL}"
            }
        }
        
        stage('Quality & Security Checks') {
            parallel {
                stage('Linting (Flake8)') {
                    steps {
                        echo 'Running Python Linting...'
                        sh 'flake8 python/ || true'
                    }
                }
                stage('Security (Trivy)') {
                    steps {
                        echo 'Running Security Scan...'
                        sh 'trivy fs --severity HIGH,CRITICAL --no-progress .'
                    }
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker Image...'
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                echo 'Authenticating and Pushing to Docker Hub...'
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKER_USER --password-stdin"
                sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully! Image is live on Docker Hub.'
        }
        failure {
            echo 'Pipeline failed. Check the logs above to debug.'
        }
    }
}