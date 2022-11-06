pipeline {
    environment {
        registry = "sandeep4642.azurecr.io"
        registryrepo = "/apps/springboot"
        registryCredential = 'azure-container-registry'
        dockerImage = ''
        dockerfile = 'spring-boot-server/'
      }
    agent { label "slave-1"}
    stages {
        stage('mvn build'){
            steps{
                sh 'cd spring-boot-server && mvn clean -DSkipTests install package'
            }
        }
        stage('Building Docker image') {
            steps{
              script {
                dockerImage = docker.build(registry + registryrepo + ":$BUILD_NUMBER", dockerfile)
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
