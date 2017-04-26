pipeline {
  agent {
    node {
      label 'batukeira_docker'
    }
    
  }
  stages {
    stage('Checkout SCM') {
      steps {
        git(url: 'https://github.com/Adrxx/Batukeira', branch: 'master')
      }
    }
    stage('Docker Compose') {
      steps {
        sh 'docker-compose build'
        sh 'docker-compose up'
      }
    }
  }
}