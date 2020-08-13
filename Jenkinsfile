pipeline {
    agent {
        docker {
            image '84.201.144.112:8123/mydockerrepo/buildserv'
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
                sh 'docker login -u admin -p 1qaz http://84.201.144.112:8123 && docker tag app 84.201.144.112:8123/app && docker push 84.201.144.112:8123/app'
            }
        }
        
        stage ('deploy') {
            steps {
                sshagent (credentials: ['7832c568-88bb-45fb-9fb2-88ad69f9f8e8']) {
                    sh 'ssh root@130.193.45.108 && docker login -u admin -p 1qaz http://84.201.144.112:8123 && docker pull 84.201.144.112:8123/app && docker run -d app'
                }
            }
        }
    }
}