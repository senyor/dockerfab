node ('linux && docker') {

    stage ('Prepare build') {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-username-password', passwordVariable: 'REGISTRY_PASSWORD', usernameVariable: 'REGISTRY_USER')]) {
            sh "docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD}"
        }
    }

    stage ('Build Docker images') {
        checkout scm

        sh 'echo "Build base docker image"'
        sh 'docker build -t senyor/docker:latest -f ./docker/docker/Dockerfile .'
        sh 'docker push senyor/docker:latest'
    }
}
