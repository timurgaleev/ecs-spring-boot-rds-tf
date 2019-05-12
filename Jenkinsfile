node {
   stage('SCM checkout'){
        checkout scm
    }
  stage 'Docker build'
  docker.build('demo')
 
  stage 'Docker push'
  docker.withRegistry('035898547283.dkr.ecr.eu-central-1.amazonaws.com/provectus_app', 'ecr:us-east-1:ecr-credentials') {
    docker.image('provectus-image-app').push('latest')
  }
}
