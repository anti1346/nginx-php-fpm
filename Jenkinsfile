//Jenkinsfile (Declarative Pipeline)
environment {
    SLACK_CHANNEL = '#alert_cicd'
}

node {
    stage('start') {
        steps {
            slackSend (channel: SLACK_CHANNEL, color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
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