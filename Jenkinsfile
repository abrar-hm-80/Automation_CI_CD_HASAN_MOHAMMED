pipeline {
  agent any
  stages {
    stage("verify tooling") {
      steps {
        sh '''
          docker version
          docker info
          docker compose version 
          curl --version
          mvn --version
        '''
      }
    }
    stage('Maven build') {
      steps {
        sh './scripts/run_all.sh'
        sh 'docker system prune -a --volumes -f'
      }
    }
    stage('Start container') {
      steps {
        sh 'docker compose up -d --no-color --wait'
        sh 'docker compose ps'
      }
    }
    stage('Run tests against the container') {
      steps {
        sh 'curl http://localhost:9090'
      }
    }
  }

  stage('Deploiement en dev'){
        environment
        {
        KUBECONFIG = credentials("config") // we retrieve  kubeconfig from secret file called config saved on jenkins
        }
            steps {
                script {
                sh '''
                rm -Rf .kube
                mkdir .kube
                ls
                cat $KUBECONFIG > .kube/config
               // cp fastapi/values.yaml values.yml
               // cat values.yml
               // sed -i "s+tag.*+tag: ${DOCKER_TAG}+g" values.yml
               // helm upgrade --install app fastapi --values=values.yml --namespace dev
                '''
                }
            }
        }
stage('Deploiement en Test'){
        environment
        {
        KUBECONFIG = credentials("config") // we retrieve  kubeconfig from secret file called config saved on jenkins
        }
            steps {
                script {
                sh '''
                rm -Rf .kube
                mkdir .kube
                ls
                cat $KUBECONFIG > .kube/config
                '''
                }
            }
        }
stage('Deploiement en staging'){
        environment
        {
        KUBECONFIG = credentials("config") // we retrieve  kubeconfig from secret file called config saved on jenkins
        }
            steps {
                script {
                sh '''
                rm -Rf .kube
                mkdir .kube
                ls
                cat $KUBECONFIG > .kube/config
                '''
                }
            }
        }
  stage('Deploiement en prod'){
        environment
        {
        KUBECONFIG = credentials("config") // we retrieve  kubeconfig from secret file called config saved on jenkins
        }
            steps {
            // Create an Approval Button with a timeout of 15minutes.
            // this require a manuel validation in order to deploy on production environment
                    timeout(time: 15, unit: "MINUTES") {
                        input message: 'Do you want to deploy in production ?', ok: 'Yes'
                    }

                script {
                sh '''
                rm -Rf .kube
                mkdir .kube
                ls
                cat $KUBECONFIG > .kube/config
                //cp fastapi/values.yaml values.yml
               // cat values.yml
               // sed -i "s+tag.*+tag: ${DOCKER_TAG}+g" values.yml
                //helm upgrade --install app fastapi --values=values.yml --namespace prod
                '''
                }
            }
        }

environment {
    DOCKER_ID = 'abrarhm'
    DOCKER_IMAGE = 'datascientestapi'
    DOCKER_TAG = "v.${BUILD_ID}.0" // we will tag our images with the current build in order to increment the value by 1 with each new build
  }

post { // send email when the job has failed
    // ..
    failure {
        echo "This will run if the job failed"
        mail(to: 'abrar.hasan1@protonmail.com'
             subject: "${env.JOB_NAME} - Build # ${env.BUILD_ID} has failed",
             body: "For more info on the pipeline failure, check out the console output at ${env.BUILD_URL}"
    }
    // ..
     always {
      sh 'docker compose down --remove-orphans -v'
      sh 'docker compose ps'
    }

  }
}

