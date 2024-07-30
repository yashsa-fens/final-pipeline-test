pipeline {
    agent any
    
    environment {
        AWS_CREDENTIALS_ID = credentials('AWS Credentials')
    }

    stages {
        stage('checkout'){
            checkout scm
        }

        stage('Run Script') {
            steps {
                script {
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
