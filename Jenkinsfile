//Jenkinsfile (Declarative Pipeline)
node {
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