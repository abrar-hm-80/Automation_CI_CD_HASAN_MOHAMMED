pipeline {
  agent any
  stages {
    stage('verify supported software') {
      steps {
        sh '''
          java -version
         docker version
        '''
      }
    }

    stage('Maven build') {
      steps {
        sh 'docker system prune -a --volumes -f'
        sh './scripts/run_all.sh'
       
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
        echo 'Push docker images to DockerHub : using docker compose multiple microservices'
      }
    }

  
    stage('Run tests against the container') {
      steps {
        echo 'Test should be applied after the deployment on the different servers'
        sh 'docker-compose logs'
        echo 'Discovery Server - http://localhost:8761'
        sh 'curl -Is http://localhost:8761 | head -n 1'
        echo 'Config Server - http://localhost:8888'
        sh 'curl -Is http://localhost:8888 | head -n 1'
        echo 'AngularJS frontend (API Gateway) - http://localhost:8085'
        sh 'curl -Is http://localhost:8085 | head -n 1'
        echo 'Tracing Server (Zipkin) - http://localhost:9411/zipkin/'
        sh 'curl -Is http://localhost:9411/zipkin/ | head -n 1'
        echo 'Admin Server (Spring Boot Admin) - http://localhost:9090'
        sh 'curl -Is http://localhost:9090 | head -n 1'
        echo 'Grafana Dashboards - http://localhost:3000'
        sh 'curl -Is http://localhost:3000 | head -n 1'
        echo 'Prometheus - http://localhost:9091'
        sh 'curl -Is http://localhost:9091 | head -n 1'
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
