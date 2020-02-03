pipeline {
    agent any
    stages {
        stage('Setup Environment') {
            steps {
                script {
                    sh .ci/setup
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}