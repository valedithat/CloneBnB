Jenkinsfile (Declaritive Pipeline)

pipeline {
	agent {docker 'ruby'}
	stages {
		stage('build') {
			sh 'ruby --version'
		}
		stage('Test on Linux') {
				agent {
						label 'linux'
				}
				steps {
						unstash 'app'
						sh 'sh rspec'
				}
				post {
						always {
								junit '**/target/*.xml'
						}
				}
			}
		}
	}
}
