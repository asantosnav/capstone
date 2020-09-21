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
        stage('Point to cluster'){
            steps{
                withAWS(region: 'us-west-2', credentials: 'aws-superuser'){
                    sh '''
                        aws eks --region us-west-2 update-kubeconfig --name cluster-capstone
                        kubectl config use-context arn:aws:eks:us-west-2:113497486547:cluster/cluster-capstone
                    '''

                }
            }
        }
        stage ('Deploy image'){
            steps{
                withAWS(region: 'us-west-2', credentials: 'aws-superuser'){
                        sh 'kubectl apply -f update-controller.yaml'
                        sh 'kubectl set image deployment/capstone-rolling-update mycontainer=asantosnav/capstone:latest --record'
                        sh 'kubectl get nodes'
                        sh 'kubectl get deployment'
                        sh 'kubectl get pod -o wide'
                        sh 'kubectl get service/capstone-expose'
                }
            }
        }        
    }
}