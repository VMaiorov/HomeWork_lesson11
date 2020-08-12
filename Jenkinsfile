pipeline {
    agent {
        docker {
            image '130.193.46.138:8123/mydockerrepo/buildserv'
        }
    }
    stages {
        
        stage ('git clone') {
            steps {
                git 'https://github.com/VMaiorov/boxfuse7.git'
            }    
        }
        
        stage ('build') {
            steps {
                sh 'mvn package'
            }
        }
        
        stage ('create docker image') {
            steps {
                sh 'docker volume create -d local --name artifact && cp /boxfuse7/target/*.war var/lib/docker/volume/artifact/_data && docker run -d -v artifact:/usr/local/tomcat/webapps --name app tomcat:latest && docker commit app app'
            }
        }
        
        stage ('push image to registry') {
            steps {
                sh 'docker login -u admin -p 1qaz http://130.193.46.138:8123 && docker tag app 130.193.46.138:8123/app && docker push 130.193.46.138:8123/app'
            }
        }
        
        stage ('deploy') {
            steps {
                sshagent (credentials: ['593b6ae5-6e95-4197-9046-6a41d437cad7']) {
                    sh 'ssh root@84.201.149.201 && docker login -u admin -p 1qaz http://130.193.46.138:8123 && docker pull 130.193.46.138:8123/app && docker run -d app'
                }
            }
        }
    }
}