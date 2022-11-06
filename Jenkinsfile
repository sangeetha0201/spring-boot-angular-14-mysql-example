pipeline {
    environment {
        registry = "sandeep4642.azurecr.io"
        registryrepo = "/apps/springboot"
        registryCredential = 'azure-container-registry'
        dockerImage = ''
      }
    agent { label "slave-1"}
    stages {
        stage('mvn build'){
            steps{
                sh 'cd spring-boot-server'
                sh 'mvn clean package'
            }
        }
        stage('Building Docker image') {
            steps{
              script {
                dockerImage = docker.build registry + registryrepo + ":$BUILD_NUMBER"
              }
            }
        
        }
        stage('Deploy push') {
            steps{
              script {
                docker.withRegistry( 'https://' + registry + registryrepo + ":$BUILD_NUMBER", registryCredential ) {
                  dockerImage.push()
                }
              }
            }
          }
        stage('Remove Unused docker image') {
            steps{
              sh "docker rmi $registry:$BUILD_NUMBER"
            }
          }
     }
    }
