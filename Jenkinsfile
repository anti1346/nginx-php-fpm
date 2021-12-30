//Jenkinsfile (Declarative Pipeline)
node {
    stages {
        stage('git clone(github)') {
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