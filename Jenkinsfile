pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/spring-petclinic'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Jaya1728/spring-petclinic.git'
            }
        }

        stage('Build with Maven & Run Unit Tests') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }

        stage('Run Docker Container Locally') {
            steps {
                script {
                    sh 'docker run -d -p 8090:8080 --name spring-petclinic $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        stage('Test Application Endpoint') {
            steps {
                script {
                    sleep 10
                    sh 'curl --silent --fail http://localhost:8080 || exit 1'
                }
            }
        }

        stage('Clean Up Container') {
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
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
