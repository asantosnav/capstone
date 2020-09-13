pipeline {
    agent any
    stages{
        stage('Lint python'){
            steps{
                pylint app.py
            }
        }
        stage('Build Docker'){
            steps{
                script{
                    docker build https://github.com/asantosnav/capstone.git
                }
                
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
