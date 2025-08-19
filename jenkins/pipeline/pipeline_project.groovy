pipeline {
    agent any
    stages {
        stage('Clone repository and Clean it') {
            steps {
                sh "rm -rf jenkins/my-app"
                sh "git clone https://github.com/Alex0424/CI-CD.git"
                sh "mvn clean -f jenkins/my-app"
            }
        }
        stage('Test') {
            steps {
                sh "mvn test -f jenkins/my-app"
            }
        }
        stage('Deploy') {
            steps {
                sh "mvn package -f jenkins/my-app"
            }
        }
    }
}