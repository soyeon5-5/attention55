pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        REGION = credentials('AWS_REGION')
    }

    stages {
        
        stage('Plan') {

            steps {
                sh 'terraform init -reconfigure'
                ///sh 'terraform init -upgrade'
                sh "terraform validate"
                sh "terraform init"
                sh "terraform plan"
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }
           
           steps {
               script {
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please, review the plan01-ec2-jh')]

               }
           }
       }

        stage('Apply') {
            steps {
                sh "terraform apply --auto-approve"
            }
        }
    }
}