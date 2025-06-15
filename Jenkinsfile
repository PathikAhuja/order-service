pipeline {
    agent any

    environment {
        IMAGE_NAME = "order-service"
        DOCKER_USER = "your-dockerhub-user"
        KUBE_CONFIG_CREDENTIAL_ID = 'kubeconfig-credentials-id'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-org/order-service.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_USER}/${IMAGE_NAME}:${BUILD_NUMBER}")
                    docker.withRegistry('', 'dockerhub-credentials-id') {
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBE_CONFIG_CREDENTIAL_ID, variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG_FILE
                        kubectl apply -f deployment/order-deployment.yaml
                        kubectl apply -f deployment/order-service.yaml
                    '''
                }
            }
        }
    }
}
