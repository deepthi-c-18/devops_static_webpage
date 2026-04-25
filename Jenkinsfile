pipeline {
    agent any

    environment {
        IMAGE_NAME = 'simple-html-app'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                    sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy/Run') {
            steps {
                script {
                    echo "Removing existing container if it exists..."
                    try {
                        sh "docker rm -f my-running-app"
                    } catch (Exception e) {
                        echo "Container did not exist, proceeding with deployment..."
                    }
                    
                    echo "Running the new Docker container..."
                    // Maps port 8081 on your host machine to port 80 in the container
                    sh "docker run -d -p 8081:80 --name my-running-app ${IMAGE_NAME}:latest"
                }
            }
        }
    }
    
    post {
        success {
            echo "Pipeline completed successfully! App should be running on http://localhost:8081"
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}
