pipeline {
    agent any
    stages{
        stage('Lint python'){
            steps{
                sh 'tidy -q -e *.html'
            }
        }
        stage('Build Docker'){
            steps{
                sh '''docker build https://github.com/asantosnav/capstone.git'''
            }        
        }
		stage('Push image'){
            steps{
                dockerpath=asantosnav/capstone
				cat ~/docker_password.txt | docker login --username asantosnav --password-stdin
				docker tag api $dockerpath
				docker push $dockerpath
				
            }        
        }        
    }
}