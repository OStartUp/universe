pipeline {
    agent any
    // node {
    //     checkout([$class: 'GitSCM',
    //             branches: [[name: '*/master']],
    //             doGenerateSubmoduleConfigurations: false,
    //             extensions: [[$class: 'CloneOption',
    //                     depth: 0,
    //                     noTags: false,
    //                     reference: '', shallow: false]],
    //             submoduleCfg: [],
    //             userRemoteConfigs: [[]]]
    //         )
    // }
    stages {
        stage('Setup Environment') {
            steps {
                sh '.ci/setup'
            }
        }
        stage('Computing changes and Dependency Graph') {
            steps {
                sh  """
                    export PATH=\${PATH}:\$(pwd)
                    echo ""
                    echo ""
                    echo ""
                    git fetch --tag
                    echo "Tags:"
                    git tag
                    echo "### Changed Files ###"
                    echo "production_pointer is in:"
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
                    git fetch --tag
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