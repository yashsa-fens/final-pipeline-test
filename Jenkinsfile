pipeline {
    agent any
    
    environment {
        AWS_CREDENTIALS_ID = credentials('33a27540-5ce7-469c-9155-8e660f98fd92')
    }

    stages {

        stage('Run Script') {
            steps {
                script {
                    // Check if the script exists
                    if (fileExists('script.sh')) {
                        // Execute the Bash script using Git Bash
                        bat '"C:\\Program Files\\Git\\bin\\bash.exe" -c "bash script.sh 0 apply"'
                    } else {
                        error 'script.sh not found'
                    }
                }
            }
        }
    }
}