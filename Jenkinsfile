pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "registry.coids.inpe.br"
        REPOSITORY = "skyops"
        IMAGE_NAME = "core"
        IMAGE_TAG = "${BUILD_NUMBER}"        
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        sh 'docker build -t $DOCKER_REGISTRY/$REPOSITORY/$IMAGE_NAME:$IMAGE_TAG -t $DOCKER_REGISTRY/$REPOSITORY/$IMAGE_NAME:latest .'
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
                        sh 'docker push $DOCKER_REGISTRY/$REPOSITORY/$IMAGE_NAME:$IMAGE_TAG'
                        sh 'docker push $DOCKER_REGISTRY/$REPOSITORY/$IMAGE_NAME:latest'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }

        stage('Deploy to Swarm') {
            steps {
                script {
                    try {
                        echo "Deploying image $DOCKER_REGISTRY/$REPOSITORY/$IMAGE_NAME:$IMAGE_TAG to live"

                        sh 'deploy ${REPOSITORY} ${IMAGE_NAME} ${IMAGE_TAG}'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }        
    }

    post {
        always {
            // Garantir que a limpeza de imagens será sempre executada no final
            echo "Cleaning up Docker resources..."

            // Remover containers parados, volumes não usados, redes não usadas e imagens não referenciadas
            sh 'docker system prune -af --volumes'
        }
        
        success {
            echo 'Imagem Docker foi enviada com sucesso!'
        }
        
        failure {
            echo 'Falha ao construir ou enviar a imagem Docker.'
        }
    }
}
