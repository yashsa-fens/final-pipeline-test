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
                    
                    bat '"C:\\Program Files\\Git\\bin\\bash.exe" -c "bash script.sh 0 apply"'

                }
            }
        }
    }
}
