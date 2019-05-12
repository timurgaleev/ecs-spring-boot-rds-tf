node {
   stage('SCM checkout'){
        checkout scm
    }
  stage 'Docker build'
  docker.build('demo')
 
  stage 'Docker push'
  docker.withRegistry('https://35898547283.dkr.ecr.us-west-2.amazonaws.com/provectus_app', 'ecr:us-west-2:ecr-credentials') {
    docker.image('provectus-app').push('latest')
  }
}
