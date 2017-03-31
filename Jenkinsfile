node {
    stage ('Build Docker images') {
        withTool('docker') {
            echo 'Build base docker image'
            docker build -t senyor/docker ./docker/docker/Dockerfile
        }
    }
}
