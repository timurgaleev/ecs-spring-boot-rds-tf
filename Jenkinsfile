node {
   stage('SCM checkout'){
        checkout scm
    }
  stage 'Docker build'
  docker.build('demo')
 
  stage 'Docker push'
  docker.withRegistry('https://035898547283.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:ecr-credentials') {
    docker.image('provectus_app').push('latest')
  }
}
