serverId: 'arty'
   pipeline {
	   agent {node "slave"}
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
                sh 'docker build -t ripy .'
            }
        }
       stage('Deploy Artifacts') { 
             steps {
                script {			 
                     def server = Artifactory.server 'jfrog' 
                     def uploadSpec = """{
                       "files": [
                            {
                              "pattern": "/var/lib/jenkins/workspace/git-jfrog/target/*.war",
                              "target": "myrepo/"
                            }
                                ]
                    }"""
	                server.upload(uploadSpec)
	            }
	          }
	        }
	        stage('Build Docker Image') {
             steps {
               echo 'Building Docker image'
               sh 'docker build -t test .'
                }
            }
        stage ('Uploading to Ecr') {
            steps {
                echo "uploading to ECR "
                sh '$(aws ecr get-login --no-include-email --region ap-south-1)'
                sh 'docker tag test:latest 937382548142.dkr.ecr.ap-south-1.amazonaws.com/myecr:latest'
                sh 'docker push 937382548142.dkr.ecr.ap-south-1.amazonaws.com/myecr:latest'
            }
        }
        
        
        stage ('Deploying to eks') {
            steps {
                 echo "Deploying imgae to EKS"
                 sh 'rm -rf /var/lib/jenkins/.kube/ && aws eks update-kubeconfig --name myeks1 --region ap-south-1'
                 sh 'kubectl apply -f deploy.yml'
                 sh 'kubectl apply -f service.yml'
            }
        }
}
}
