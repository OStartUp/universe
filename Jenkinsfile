pipeline {
    agent any
    stages {
        stage('Setup Environment') {
            steps {
                sh '.ci/setup'
            }
        }
        stage('Unit Test') {
            steps {
                echo 'Testing..'
                sh  """
                    export PATH=\${PATH}:\$(pwd)
                    echo ""
                    echo ""
                    echo ""
                    echo "### TESTING ###"
                    ./test_impacted production_pointer HEAD
                    """
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}