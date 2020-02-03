pipeline {
    agent any
    stages {
        stage('Setup Environment') {
            steps {
                sh .ci/setup
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