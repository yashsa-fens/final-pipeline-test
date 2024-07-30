pipeline {
    agent any

    environment {
        AWS_CREDENTIALS_ID = credentials('AWS Credentials')
    }

    stages {
        stage('checkout'){
            steps{
                script {
                    checkout scm
                }
            }
        } 
        stage('Run Script') {
            steps {

                bat 'script.sh 0 apply'
                    
                
            }
        }
    }
}
