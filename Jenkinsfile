pipeline {
    agent any
    stages {
        stage('Setup Environment') {
            steps {
                sh '.ci/setup'
            }
        }
        stage('Computing changes') {
            steps {
                echo 'Testing..'
                sh  """
                    export PATH=\${PATH}:\$(pwd)
                    echo ""
                    echo ""
                    echo ""
                    echo "### Changed Files ###"
                    git diff --name-only production_pointer HEAD
                    echo "### Generating Dependency Graph ###"
                    ./generates_deps
                    """
                
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
         post {
            always {
                archiveArtifacts artifacts: '*.png', fingerprint: true
               // junit 'build/reports/**/*.xml'
           }
    }
}