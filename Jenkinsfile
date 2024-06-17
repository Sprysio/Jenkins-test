pipeline {
    agent { 
        node {
            label 'docker-agent-python3'
            }
      }
    triggers {
        pollSCM '*/5 * * * *'
      }
      
      post{
        always {  
             echo 'This will always run'  
         }  
         success {  
             echo 'This will run only if successful'  
         }  
         failure {  
            echo 'This will run only if failure'  
             mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "sebastianfors123@tutanota.com";  
         }  
         unstable {  
             echo 'This will run only if the run was marked as unstable'  
         }  
         changed {  
             echo 'This will run only if the state of the Pipeline has changed'  
             echo 'For example, if the Pipeline was previously failing but is now successful'  
         }
      }
    stages {
        stage('Setup Docker') {
            steps {
                sh '''
                # Install Docker CLI if not already installed
                if ! command -v docker &> /dev/null; then
                    echo "Docker not found, installing..."
                    sudo apt-get update
                    sudo apt-get install -y docker.io
                else
                    echo "Docker is already installed"
                fi
                '''
            }
        }
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
                cd myapp
                sudo docker build -t my-app -f sprysio/jenkins_test .
                '''
            }
        }
    }
}