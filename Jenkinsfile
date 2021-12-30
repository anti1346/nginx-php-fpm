pipeline {
  agent any

  environment {
    SLACK_CHANNEL = '#alert-cicd'
  }

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
        slackSend(channel: '${SLACK_CHANNEL} ', notifyCommitters: true, replyBroadcast: true, sendAsText: true, username: 'Jenkins Blue Ocean')
      }
    }

    stage('Build image') {
      app = docker.build("anti1346/nginx-php-fpm:$BUILD_NUMBER")
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