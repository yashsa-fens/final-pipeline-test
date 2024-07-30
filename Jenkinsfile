pipeline {
    agent any
    

    stages {
        stage('checkout'){
            steps{
            checkout scm
            }
        }

        stage('Run Script') {
            steps {
                script {
                     withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS Credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]){
                    // Check if the script exists
                    if (fileExists('script.sh')) {
                        // Execute the Bash script using Git Bash
                        bat 'script.sh 0 apply'
                    } else {
                        error 'script.sh not found'
                    }
                     }
                }
            }
        }
    }
}
