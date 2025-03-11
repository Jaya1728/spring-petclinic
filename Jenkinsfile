
 pipeline {
    agent any

    environment {
        IMAGE_NAME = "springpetclinic"
        CONTAINER_NAME = "springpetclinic"
    }

    triggers {
        pollSCM('* * * * *') // Trigger on code changes
        cron('H 0 * * *')    // Trigger every night at 12 AM
    }

    stages {
        stage('Checkout Code') {
            steps {
                  git branch: 'main', url: 'https://github.com/Jaya1728/spring-petclinic.git'
}
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                    docker run -d --name $CONTAINER_NAME -p 8080:8080 $IMAGE_NAME
                '''
            }
        }
    }
}

