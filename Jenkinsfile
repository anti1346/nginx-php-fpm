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
        sh 'docker rmi $(docker images -f "dangling=true" -q) || true'
        sh 'docker run -d --name nginx-php-fpm -p 8888:80 anti1346/nginx-php-fpm:latest'
      }
    }

    // stage('docker container test') {
    //   steps {
    //     sh '''NGINX=$(curl --write-out %{http_code} --silent --output /dev/null localhost:8888/test.html)
    //     if [ $NGINX -ne 200 ]
    //       then
    //       echo localhost(nginx) is down
    //     fi
    //     '''
    //     sh '''PHP-FPM=$(curl --write-out %{http_code} --silent --output /dev/null localhost:8888/test.php)
    //     if [ $PHPFPM -ne 200 ]
    //       then
    //       echo localhost(php-fpm) is down
    //     fi'''
    //   }
    // }

    stage("Using curl example") {
      steps {
        script {
          final String url = "localhost:8888/test.html"
          final String response = sh(script: "curl -s $url", returnStdout: true).trim()
          final def (String response, int code) =
            sh(script: "curl -s -w '\\n%{response_code}' $url", returnStdout: true)
              .trim()
              .tokenize("\n")
          echo "HTTP response status code: $code"
          if (code == 200) {
            echo response
          }
          echo response
        }
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