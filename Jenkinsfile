//Jenkinsfile update
pipeline {
    agent none

    options { skipDefaultCheckout(true) }

    stages {
        stage('Start') {
            agent any

            steps {
                slackSend (channel: '#migrator', color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
        }

        stage('=========> Clone repository') {
            checkout scm
        }

        stage('=========> Build image') {
            app = docker.build("anti1346/nginx-php-fpm") //저장소
        }
    
    // stage('=========> Test image') {
    //     app.inside {
    //         sh """
    //         docker run -d --name playground3 -p 8888:80 anti1346/nginx-php-fpm:latest'
    //         curl -s localhost:9999
    //         """
    //     }
    // }

        stage('=========> Push image') {
            docker.withRegistry('https://registry.hub.docker.com', 'dockerimagepush') { //Jenkins Credential 정보
                app.push("${env.BUILD_NUMBER}") //빌드 번호
                app.push("latest") //태그 정보
            }
        }

    post {
        success {
            slackSend (channel: '#migrator', color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
        failure {
            slackSend (channel: '#migrator', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}