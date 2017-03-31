node ('linux && docker') {

    stage ('Prepare build') {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-username-password', passwordVariable: 'REGISTRY_PASSWORD', usernameVariable: 'REGISTRY_USER')]) {
            sh "docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD}"
        }
        checkout scm
        sh 'docker rmi $(docker images -a | grep "^<none>" | awk "{print $3}") > /dev/null 2>&1'
    }

    stage ('Build and push Base docker images') {

        sh 'echo "Build base docker image"'
        sh 'docker build -t senyor/docker:latest -f ./docker/docker/Dockerfile .'
        sh 'docker push senyor/docker:latest'

        sh 'echo "Build docker-compose image"'
        sh 'docker build -t senyor/docker-compose:latest -f ./docker/docker-compose/Dockerfile .'
        sh 'docker push senyor/docker-compose:latest'

        sh 'echo "Build docker-node image"'
        sh 'docker build -t senyor/docker-node:latest -f ./docker/docker-node/Dockerfile .'
        sh 'docker push senyor/docker-node:latest'

        sh 'echo "Build base docker-node-fat image"'
        sh 'docker build -t senyor/docker-node-fat:latest -f ./docker/docker-node-fat/Dockerfile .'
        sh 'docker push senyor/docker-node-fat:latest'
    }

    stage ('Build and push Java docker images') {

        sh 'echo "Build Java8 docker image"'
        sh 'docker build -t senyor/java8:latest -f ./java/java8/Dockerfile .'
        sh 'docker push senyor/java8:latest'
    }

    stage ('Build and push Gradle-Git docker images') {

        sh 'echo "Build java8-gradle3 docker image"'
        sh 'docker build -t senyor/java8-gradle3:latest -f ./gradle/java8-gradle3/Dockerfile .'
        sh 'docker push senyor/java8-gradle3:latest'

        sh 'echo "Build java8-gradle3-git2 docker image"'
        sh 'docker build -t senyor/java8-gradle3-git2:latest -f ./gradle/java8-gradle3-git2/Dockerfile .'
        sh 'docker push senyor/java8-gradle3-git2:latest'

        sh 'echo "Build java8-gradle3-git2-docker docker image"'
        sh 'docker build -t senyor/java8-gradle3-git2-docker:latest -f ./gradle/java8-gradle3-git2-docker/Dockerfile .'
        sh 'docker push senyor/java8-gradle3-git2-docker:latest'

        sh 'echo "Build java8-gradle3-git2-docker-compose docker image"'
        sh 'docker build -t senyor/java8-gradle3-git2-docker-compose:latest -f ./gradle/java8-gradle3-git2-docker-compose/Dockerfile .'
        sh 'docker push senyor/java8-gradle3-git2-docker-compose:latest'
    }
}
