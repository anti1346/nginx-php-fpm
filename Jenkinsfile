//Jenkinsfile (Declarative Pipeline)
node {
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