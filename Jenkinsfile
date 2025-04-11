node {
    environment {
        APP_NAME = "springpetclinic"
        dockerImage= "target/spring-petclinic-2.7.3.jar"
    }

    triggers {
        pollSCM('* * * * *')
        cron('H 0 * * *')
    }

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

          stage('Test') {
        junit '**/target/surefire-reports/TEST-*.xml'
        archiveArtifacts 'target/*.jar'


        }
    stage('Build Docker Image') {
        sh "docker build -t ${dockerImage} ."
    }

  stage('Run Docker Container') {
        // Stop and remove any previous container
        sh "docker rm -f ${APP_Name} || true"
        // Run new container
        sh "docker run -d --name ${APP_Name} -p 9090:8090 ${dockerImage}"
    }
}
