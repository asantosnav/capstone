pipeline {
    agent any
    stages{
        stage('Lint HTML'){
            steps{
                sh 'tidy -q -e *.html'
            }
        }
        stage('Build Docker'){
            steps{
                sh '''docker build https://github.com/asantosnav/capstone.git --tag=cap'''
            }        
        }
		stage('Push image'){
            steps{
                sh '''
                    dockerpath=asantosnav/capstone
				    cat ~/docker_password.txt | docker login --username asantosnav --password-stdin
				    docker tag cap $dockerpath
				    docker push $dockerpath
                '''
				
            }        
        }        
    }
}