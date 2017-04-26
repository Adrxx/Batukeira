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
    stage('ls') {
      steps {
        sh 'ls'
      }
    }
  }
}