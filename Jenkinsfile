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

    stage('docker image build') {
      steps {
        sh 'docker build --tag anti1346/nginx-phpfpm:0.0.1 .'
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
  
  stage('=========> Push image') {
      docker.withRegistry('https://registry.hub.docker.com', 'dockerimagepush') { //Jenkins Credential 정보
          app.push("${env.BUILD_NUMBER}") //빌드 번호
          app.push("latest") //태그 정보
      }
  }
}