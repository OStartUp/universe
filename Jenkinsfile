pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building'
                echo '$PATH'
                sudo apt-get install bazel
                bazel version
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