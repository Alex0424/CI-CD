pipeline {
    agent any
    stages {
        stage('Clone repository and Clean it') {
            steps {
                sh "rm -rf CI-CD"
                sh "git clone https://github.com/Alex0424/CI-CD.git"
                sh "mvn -f CI-CD/jenkins/pipeline/ clean"
            }
        }
        stage('Test') {
            steps {
                sh "mvn -f CI-CD/jenkins/pipeline test"
            }
        }
        stage('Deploy') {
            steps {
                sh "mvn -f CI-CD/jenkins/pipeline package"
            }
        }
    }
}