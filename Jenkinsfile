pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "registry.coids.inpe.br"
        IMAGE_NAME = "my-image"  // Nome da sua imagem Docker
        IMAGE_TAG = "latest"     // Tag da imagem (pode ser qualquer valor)
    }

    stages {
        stage('Checkout') {
            steps {
                // Baixar o código do repositório Git
                git 'https://github.com/luizcoura/jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construir a imagem Docker
                    sh 'docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG .'
                }
            }
        }

        stage('Push Image to Registry') {
            steps {
                script {
                    // Empurrar a imagem para o registry
                    sh 'docker push $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG'
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
