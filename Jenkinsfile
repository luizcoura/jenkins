pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "registry.coids.inpe.br"
        IMAGE_NAME = "my-image"
        IMAGE_TAG = "${BUILD_NUMBER}"        
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        sh 'docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG -t $DOCKER_REGISTRY/$IMAGE_NAME:latest .'
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
                        sh 'docker push $DOCKER_REGISTRY/$IMAGE_NAME:latest'
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
                        echo "Deploying image $DOCKER_REGISTRY/$IMAGE_NAME:$image_tag to production"

                        sh 'deploy ${IMAGE_TAG} ${IMAGE_NAME}'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }        

        stage('Cleanup') {
            steps {
                script {
                    sh 'docker system prune -f'
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
