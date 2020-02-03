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
                sh  """
                    export PATH=\${PATH}:\$(pwd)
                    echo ""
                    echo ""
                    echo ""
                    which git
                    git --version
                    echo "### Changed Files ###"
                    production_pointer is in:
                    git rev-list -n 1 production_pointer
                    git diff --name-only production_pointer \${GIT_COMMIT}
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
                    ./test_impacted production_pointer \${GIT_COMMIT}
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