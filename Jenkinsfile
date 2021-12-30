pipeline {
  agent any
  stages {
    stage('date') {
      steps {
        timestamps() {
          sh 'date'
        }

      }
    }

    stage('slack send') {
      steps {
        slackSend(channel: '#alert-cicd', notifyCommitters: true, replyBroadcast: true, sendAsText: true, username: 'Jenkins Blue Ocean')
      }
    }

  }
}