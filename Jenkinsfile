pipeline {
    agent any
    tools {nodejs "nodejs"}
    environment {
        FRONTEND_IMAGE_NAME = 'email_summarizer'
        GITHUB_REPO_URL = 'https://github.com/keshavagarwal670/email_summarizar_devops.git'
        DOCKERHUB_CREDENTIALS = credentials('DockerHubCred')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from the GitHub repository
                    git branch: 'main', url: "${GITHUB_REPO_URL}"
                }
            }
        }

        stage('Build Frontend Docker Image') {
            steps {
                sh '''
                docker build -t agarwalkeshav670/email_summarizer .
                '''
            }
        }

        stage('Push Frontend Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'DockerHubCred') {
                        sh 'docker tag agarwalkeshav670/email_summarizer:latest agarwalkeshav670/email_summarizer:latest'
                        sh 'docker push agarwalkeshav670/email_summarizer:latest'
                    }
                }
            }
        }

        stage("Ansible Deploy cluster"){
            steps{
                ansiblePlaybook(
                    colorized: true,
                    disableHostKeyChecking: true,
                    inventory: 'ansible-deploy/inventory',
                    playbook: 'ansible-deploy/ansible-book.yaml',
                    sudoUser: 'keshav'
                )
            }
        }
    }
}
