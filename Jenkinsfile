pipeline {
    agent { 
        docker {
            image 'sprysio/python_agent:python'
            args '-v /var/run/docker.sock:/var/run/docker.sock' 
            }
      }
    triggers {
        pollSCM '*/5 * * * *'
      }
    environment {
        VENV_DIR = 'venv'
    }  
      
    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh '''
                python3 -m venv ${VENV_DIR}
                source ${VENV_DIR}/bin/activate
                cd myapp
                pip install -r requirements.txt
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                source ${VENV_DIR}/bin/activate
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
                docker build -t my-app:${BUILD_ID} -f Dockerfile .
                '''
            }
        }
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
}