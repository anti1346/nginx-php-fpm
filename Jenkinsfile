Jenkinsfile (Declarative Pipeline)
pipeline {
    agent any

    stages {
        stage('github glone') {
            checkout scm
        }
        stage('docker build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}