pipeline {
    agent {
        label 'docker-agent-python'
    }
    triggers {
        pollSCM '*/5 * * * *'
      } 
      
    stages {
        stage('Build') {
            steps {
                echo 'Building....'
                sh '''
                cd myapp
                python3 -m venv venv
                . venv/bin/activate
                pip  install -r requirements.txt
                deactivate
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd myapp
                . venv/bin/activate
                python3 hello.py
                python3 hello.py --name=Forsen
                deactivate
                '''
            }
        }
        stage('Build image'){
            steps{
                echo 'pushing to dockerhub'
                sh ''' 
                cd myapp
                docker build -t jenkins_test:${BUILD_ID} .
                '''
            }
        }
        stage('Push dockerhub')
        {
            steps{
                echo 'pushing to dockerhub'
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                
                sh '''
                cd myapp
                docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                docker push jenkins_test:${BUILD_ID} 
                
                '''
            }
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