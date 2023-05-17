pipeline {
  agent any
  stages {
    stage('verify supported software') {
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

    stage('Build docker') {
      steps {
        sh 'docker compose up -d --no-color --wait'
        sh 'docker compose ps'
      }
    }
    
    stage('Push docker images to DockerHub') {
      steps {
         echo "Push docker images to DockerHub : using docker compose multiple microservices"
      }
    }

    stage('Run tests against the container') {
      steps {
        //sh 'curl http://localhost:9090'
        echo "Test should be applied after the deployment on the different servers"
      }
    }

    stage('Deploiement en dev') {
      environment {
        KUBECONFIG = credentials('config')
      }
      steps {
        script {
          sh '''
rm -Rf .kube
mkdir .kube
ls
cat $KUBECONFIG > ~/.kube/config
'''
        }

      }
    }

    stage('Deploiement en Test') {
      environment {
        KUBECONFIG = credentials('config')
      }
      steps {
        script {
          sh '''
rm -Rf .kube
mkdir .kube
ls
cat $KUBECONFIG > ~/.kube/config
'''
        }

      }
    }

    stage('Deploiement en staging') {
      environment {
        KUBECONFIG = credentials('config')
      }
      steps {
        script {
          sh '''
rm -Rf .kube
mkdir .kube
ls
cat $KUBECONFIG > ~/.kube/config
'''
        }

      }
    }

    stage('Deploiement en prod') {
      environment {
        KUBECONFIG = credentials('config')
      }
      steps {
        timeout(time: 15, unit: 'MINUTES') {
          input(message: 'Do you want to deploy in production ?', ok: 'Yes')
        }

        script {
          sh '''
rm -Rf .kube
mkdir .kube
ls
echo "Deploiement en prod..."
cat $KUBECONFIG > ~/.kube/config
sleep 10
echo "List the URL and send it via email to team / stakeholders"
'''
        }

      }
    }
  }
}
