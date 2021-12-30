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

    stage('clone') {
      steps {
        git(url: 'https://github.com/anti1346/nginx-php-fpm.git', branch: '*/main', credentialsId: 'git-token')
      }
    }

  }
}