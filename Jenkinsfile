//Jenkinsfile update
node {
    stage('=========> Clone repository') {
        checkout scm
    }
    
    stage('=========> Build image') {
        app = docker.build("anti1346/php-apache") //저장소
    }
    
    // stage('=========> Test image') {
    //     app.inside {
    //         sh """
    //         docker run -d --name playground3 -p 8888:80 anti1346/php-apache:latest'
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
}