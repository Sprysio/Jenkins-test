pipeline {
    agent {
        label 'docker-agent-python'
    }
    triggers {
        pollSCM '*/5 * * * *'
      } 
      
    stages {
        stage('Build docker image') {
            steps {
                echo 'Build docker image....'
                sh '''
                cd myapp
                docker build -t my-app:${BUILD_ID} -f Dockerfile .
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd myapp
                docker run --rm my-app:${BUILD_ID} python3 hello.py
                docker run --rm my-app:${BUILD_ID} python3 hello.py --name=Forsen
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
             //mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "sebastianfors123@tutanota.com";  
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