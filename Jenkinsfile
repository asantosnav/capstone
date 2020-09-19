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
				    cat ~/docker_password_2.txt | docker login --username asantosnav --password-stdin
				    docker tag cap $dockerpath
				    docker push $dockerpath
                '''
				
            }        
        }
        stage('Point to cluster'){
            steps{
                withAWS(region: 'us-west-2', credentials: 'aws-static'){
                    sh '''
                        aws eks --region us-west-2 update-kubeconfig --name cluster-capstone
                    '''

                }
            }
        }
        stage ('Deploy image'){
            steps{
                sh 'kubectl set image -f ./update-controller.json'
            }
        }        
    }
}