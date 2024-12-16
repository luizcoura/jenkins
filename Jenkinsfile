pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "registry.coids.inpe.br"
        IMAGE_NAME = "my-image"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        sh 'docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG .'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }

        stage('Push Image to Registry') {
            steps {
                script {
                    try {
                        sh 'docker push $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Imagem Docker foi enviada com sucesso!'
        }
        failure {
            echo 'Falha ao construir ou enviar a imagem Docker.'
        }
    }
}
