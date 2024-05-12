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
                script {
                    // Use Docker Pipeline plugin to build the Docker image
                    docker.build("agarwalkeshav670/email_summarizer")
                }
            }
        }

            stage('Push Frontend Docker Image') {
            steps {
                script {
                    // Use Docker Pipeline plugin to push the Docker image to DockerHub
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                        docker.image("agarwalkeshav670/email_summarizer").push("latest")
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
                    sudoUser: 'adarsh'
                )
            }
        }
    }
}
