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

    stage('build') {
      steps {
        sh 'echo "build..."'
      }
    }

    stage('push') {
      steps {
        sh 'echo "docker images push"'
      }
    }

    stage('test') {
      steps {
        sh 'echo "test"'
      }
    }

    stage('deploy') {
      steps {
        sh 'echo "deploy..."'
      }
    }

  }
}