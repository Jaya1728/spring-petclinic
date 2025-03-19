pipeline {
    agent any  // Runs on any available Jenkins agent

    environment {
        APP_NAME = "springpetclinic"  // Application name
        JAR_FILE = "target/spring-petclinic-2.7.3.jar"  // Path to the built JAR file
    }

    triggers {
        pollSCM('* * * * *')  // Check for code changes every minute
        cron('H 0 * * *')     // Run the pipeline every night at 12 AM
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Jaya1728/spring-petclinic.git'
            }
        }

        stage('Build Application') {
            steps {
                sh '''
                    mvn clean package  // Compile, test, and package the application into a JAR file
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    pkill -f "$APP_NAME" || true  // Stop any running instance
                    nohup java -jar "$JAR_FILE" > app.log 2>&1 &  // Start the application in the background
                '''
            }
        }
    }
}
