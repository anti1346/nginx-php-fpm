//Jenkinsfile
environment { 
    SLACK_CHANNEL = '#alert-cide' 
}

node {
    stage("Start"){
        steps { slackSend (channel: SLACK_CHANNEL, color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})") 
    }
    stage("Clone"){
        checkout scm
    }
    stage("Build"){
        echo "Building.."
    }
    stage("Test"){
        echo "Testing.."
    }
    stage("Deploy"){
        echo "Deploying...."
    }
}