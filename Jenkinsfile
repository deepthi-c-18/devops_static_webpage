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
                    // Using 'bat' since the environment is Windows.
                    // If Jenkins is running on Linux, change 'bat' to 'sh'
                    bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                    bat "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy/Run') {
            steps {
                script {
                    echo "Removing existing container if it exists..."
                    try {
                        bat "docker rm -f my-running-app"
                    } catch (Exception e) {
                        echo "Container did not exist, proceeding with deployment..."
                    }
                    
                    echo "Running the new Docker container..."
                    // Maps port 8080 on your host machine to port 80 in the container
                    bat "docker run -d -p 8080:80 --name my-running-app ${IMAGE_NAME}:latest"
                }
            }
        }
    }
    
    post {
        success {
            echo "Pipeline completed successfully! App should be running on http://localhost:8080"
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}
