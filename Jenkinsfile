pipeline {
    agent {
      kubernetes {
        yaml """
apiVersion: "v1"
kind: "Pod"
metadata:
  annotations: {}
  labels:
    jenkins/cdplatform-jenkins-slave: "true"
  name: "default-zk75t"
spec:
  containers:
  - args:
    - "********"
    - "default-zk75t"
    env:
    - name: "JENKINS_SECRET"
      value: "********"
    - name: "JENKINS_TUNNEL"
      value: "jenkins-agent:50000"
    - name: "JENKINS_AGENT_NAME"
      value: "default-zk75t"
    - name: "JENKINS_NAME"
      value: "default-zk75t"
    - name: "JENKINS_AGENT_WORKDIR"
      value: "/home/jenkins/agent"
    - name: "JENKINS_URL"
      value: "http://jenkins.kube-system.svc.cluster.local:8080/jenkins"
    image: "kkarty/jnlp-slave-python3.7"
    imagePullPolicy: "IfNotPresent"
    name: "jnlp"
    resources:
      limits:
        memory: "512Mi"
        cpu: "512m"
      requests:
        memory: "512Mi"
        cpu: "512m"
    securityContext:
      privileged: false
    tty: false
    volumeMounts:
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
    workingDir: "/home/jenkins/agent"
  nodeSelector:
    beta.kubernetes.io/os: "linux"
  restartPolicy: "Never"
  securityContext: {}
  serviceAccount: "default"
  volumes:
  - emptyDir:
      medium: ""
    name: "workspace-volume"
"""
      }
    }
    
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

    //     post {
    // //     always {
    // //         archiveArtifacts artifacts: '*.png', fingerprint: true
    // //        // junit 'build/reports/**/*.xml'
    // //    }
    //     always {
    //         echo 'One way or another, I have finished'
    //         deleteDir() /* clean up our workspace */
    //     }
    //     success {
    //         archiveArtifacts artifacts: '*.png', fingerprint: true
    //         echo 'I succeeeded!'
    //     }
    //     unstable {
    //         echo 'I am unstable :/'
    //     }
    //     failure {
    //         echo 'I failed :('
    //     }
    //     changed {
    //         echo 'Things were different before...'
    //     }   
    //}
}