pipeline{
    agent {label: 'Node-01'}
    stages{
        stage ('Build Backend'){
            steps{
                sh './mvnw clean package -DskipTests=true'
            }
        }
          stage ('Unit Tests'){
            steps{
                sh './mvnw test'
            }
        }
          stage ('Sonar Analysis'){
              environment {
                  scannerHome = tool 'SONAR_SCANNER'
              }
            steps{
                withSonarQubeEnv('SONAR_LOCAL'){
                     sh "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://10.40.50.205:9000  -Dsonar.login=4db67ac5048bf368b5088582cc8defeddfff8baf -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"

                }
            }
        }
        /*stage('Quality Gate'){
            steps{
                sleep(5) 
                //timeout(time: 1, unit: 'MINUTES'){
                    waitForQualityGate abortPipeline: true
                //}
                
            }
        }*/
        stage('Build Container'){
            steps{
                sh 'sudo docker build -t gmoraesgarcia/teste-jenkins .'
            }
        }
       
        stage('Push dockerHub'){
            steps{
                sh 'sudo docker push gmoraesgarcia/teste-jenkins'
            }
        }

        stage('conect ssh and pull'){
            steps{
              // node('Node-01') {
                    sh 'sudo docker pull gmoraesgarcia/teste-jenkins'
                    // some block
               // }
            }
        }
    }
}