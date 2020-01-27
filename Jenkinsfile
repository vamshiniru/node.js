 serverId: 'arty'
   pipeline {
    agent any
     tools {
        maven 'maven'
        jdk 'jdk'
    }
    stages{
        stage ('build') {
            steps {
        echo "code is building"
         sh 'mvn clean'
         sh 'mvn install'
            }
        }

        stage ('Bulding docker docker image') {
            steps {
                echo "build docker image"
                sh 'docker build -t impo .'
            }
        }
        stage ('Uploading to Ecr') {
            steps {
                echo "uploading to ECR "
                sh '$(aws ecr get-login --no-include-email --region ap-northeast-1)'
                sh 'docker tag ripy:latest 526174677628.dkr.ecr.ap-northeast-1.amazonaws.com/ripecr:latest'
                sh 'docker push 526174677628.dkr.ecr.ap-northeast-1.amazonaws.com/ripecr:latest'
            }
        }
        
        
        stage ('Deploying to eks') {
            steps {
                 echo "Deploying imgae to EKS"
                 sh 'rm -rf /var/lib/jenkins/.kube/ && aws eks update-kubeconfig --name rip-eks'
                 sh 'kubectl apply -f deploy.yml'
                 sh 'kubectl apply -f service.yml'
            }
        }
}
}
