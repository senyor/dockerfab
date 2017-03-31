node ('linux && docker') {
    stage ('Build Docker images') {
        checkout scm
        sh 'echo "Build base docker image"'
        sh 'docker build -t senyor/docker -f ./docker/docker/Dockerfile .'
    }
}
