node {


    environment {
        APP_NAME = "springpetclinic"
        DOCKER_IMAGE = "springpetclinic:latest" // use a proper image tag instead of path to jar
    }

    triggers {
        pollSCM('* * * * *')  // Poll every minute
        cron('H 0 * * *')     // Daily at midnight
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Jaya1728/spring-petclinic.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                junit '**/target/surefire-reports/TEST-*.xml'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Run Docker Container') {
            steps {
                // Stop and remove any existing container
                sh 'docker rm -f $APP_NAME || true'

                // Run new container
                sh 'docker run -d --name $APP_NAME -p 9090:8080 $DOCKER_IMAGE'
                // Port mapping assumes your app runs on port 8080 inside container
            }
        }
    }
}
