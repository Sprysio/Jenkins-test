pipeline {
    agent { 
        node {
            label 'docker-agent-python3'
            }
      }
    triggers {
        pollSCM '*/5 * * * *'
      }
      environment {
        GITHUB_TOKEN = credentials('2178dedf-778c-4152-9edb-647d2d769f96')  // Replace 'github-token-id' with the ID of your GitHub token in Jenkins credentials
    }
      post{
        always {  
             echo 'This will always run'  
         }  
         success {  
             echo 'This will run only if successful'  
             updateGitHubStatus('success')
         }  
         failure {  
            echo 'This will run only if the build fails'
            updateGitHubStatus('failure')         }  
         unstable {  
             echo 'This will run only if the run was marked as unstable'  
             updateGitHubStatus('failure')
         }  
         changed {  
             echo 'This will run only if the state of the Pipeline has changed'  
             echo 'For example, if the Pipeline was previously failing but is now successful'  
         }
      }
    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh '''
                cd myapp
                pip install -r requirements.txt
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd myapp
                python3 hello.py
                python3 hello.py --name=Forsen
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo 'Deliver....'
                sh '''
                echo "doing delivery stuff.."
                '''
            }
        }
    }
}