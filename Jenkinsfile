//Jenkinsfile (Declarative Pipeline)
node {
    stage('start') {
        agent any

        steps {
            slackSend (channel: '#migrator', color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }

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