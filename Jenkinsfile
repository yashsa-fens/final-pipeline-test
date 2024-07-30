pipeline {
    agent any
    
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
                script {
                    
                    bat 'script.sh all plan'

                }
            }
        }
    }
}
