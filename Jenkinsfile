pipeline {
  agent any
  stages {
    stage('check out') {
      steps {
        timestamps() {
          sh 'date'
        }

      }
    }

    stage('slack send') {
      steps {
        slackSend(channel: '${SLACK_CHANNEL}', notifyCommitters: true, replyBroadcast: true, sendAsText: true, username: 'Jenkins Blue Ocean')
      }
    }

    stage('docker image build') {
      steps {
        sh 'docker build --tag anti1346/nginx-php-fpm:latest .'
      }
    }

    stage('docker run') {
      steps {
        sh 'docker rm -f $(docker ps -q --filter="name=nginx-php-fpm") || true'
        sh 'docker ps -f name=anti1346/nginx-php-fpm -q | xargs --no-run-if-empty docker container stop'
        sh 'docker container ls -a -fname=anti1346/nginx-php-fpm -q | xargs -r docker container rm'
        sh 'docker rmi $(docker images -f "dangling=true" -q) || true'
        sh 'docker run -d --name nginx-php-fpm -p 8888:80 anti1346/nginx-php-fpm:latest'
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
  environment {
    SLACK_CHANNEL = '#alert-cicd'
  }
}