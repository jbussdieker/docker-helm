#!groovy
latest = "2.13.1"
stable = "2.13.1"

properties([
  parameters([
    string(defaultValue: '2.13.1', description: 'Version', name: 'Version')
  ])
])

node {
  helmVersion = params.Version
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
      if (helmVersion == latest)
        image.push('latest')
      if (helmVersion == stable)
        image.push('stable')
    }
  }
}
