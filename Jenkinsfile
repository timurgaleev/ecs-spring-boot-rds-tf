pipeline {
  stage('SCM checkout'){
        checkout scm
    }
  stages {
    stage('Create Packer AMI') {
        steps {
          withCredentials([
            usernamePassword(credentialsId: 'awsCred', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY')
          ]) {
            sh 'packer build -debug -var aws_access_key=${AWS_KEY} -var aws_secret_key=${AWS_SECRET} packer/packer.json'
        }
      }
    }
    stage('AWS Deployment') {
      steps {
          withCredentials([
            usernamePassword(credentialsId: 'awsCred', passwordVariable: 'AWS_SECRET', usernameVariable: 'AWS_KEY'),
            usernamePassword(credentialsId: 'repoCred', passwordVariable: 'REPO_PASS', usernameVariable: 'REPO_USER'),
          ]) {
            sh 'rm -rf repository'
            sh 'git clone https://github.com/timurgaleev/home_task.git'
            sh '''
               cd repository
               terraform init
               terraform apply -auto-approve -var access_key=${AWS_KEY} -var secret_key=${AWS_SECRET}
               git add terraform.tfstate
               git -c user.name="timurgaleev" -c user.email="timur_galeev@outlook.com" commit -m "terraform state update from Jenkins"
               git push @github.com/timurgaleev/home_task.git">https://${REPO_USER}:${REPO_PASS}@github.com/timurgaleev/home_task.git master
            '''
        }
      }
    }
  }
}
