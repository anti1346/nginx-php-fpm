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
        sh 'docker build --tag anti1346/nginx-phpfpm:latest .'
      }
    }


    stage('docker run') {
      steps {
        sh 'docker ps -f name=anti1346/nginx-phpfpm -q | xargs --no-run-if-empty docker container stop'
        sh 'docker container ls -a -fname=anti1346/nginx-phpfpm -q | xargs -r docker container rm'
        sh 'docker rmi $(docker images -f "dangling=true" -q)'
        sh 'docker run -d --name anti1346/nginx-phpfpm -p 8080:8080 anti1346/nginx-phpfpm:latest'
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