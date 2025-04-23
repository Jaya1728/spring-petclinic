pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'spring-petclinic-image'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY = ''   
    }

    stages {
        stage('Checkout Code') {
            steps {
               git branch: 'main', url: 'https://github.com/Jaya1728/spring-petclinic.git'

            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run -d -p 8080:8080 --name spring-petclinic $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        stage('Test Application') {
            steps {
                script {
                    sleep 10
                    sh 'curl --silent --fail http://localhost:8080 || exit 1'
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    sh 'docker stop spring-petclinic || true'
                    sh 'docker rm spring-petclinic || true'
                }
            }
        }
    }

    post {
        always {
            sh 'docker rmi $DOCKER_IMAGE:$DOCKER_TAG || true'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
} 
