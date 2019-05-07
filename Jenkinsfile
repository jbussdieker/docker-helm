#!groovy
properties([
  parameters([
    string(defaultValue: '2.11.0', description: 'Helm Version', name: 'HelmVersion')
  ])
])

node {
  helmVersion = params.HelmVersion
  credentialsId = 'docker-hub-credentials'

  stage('clone') {
    checkout scm
  }

  stage('build') {
    image = docker.build("jbussdieker/helm:${helmVersion}", "--build-arg helm_version=${helmVersion} .")
  }

  stage('test') {
    image.inside {
      sh "helm version --client | grep ${helmVersion}"
    }
  }

  stage('publish') {
    docker.withRegistry("", credentialsId) {
      image.push()
    }
  }
}
