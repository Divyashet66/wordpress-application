 def scan_type
 def host
 def SendEmailNotification(String result) {
  
    // config 
    def to = emailextrecipients([
           requestor()
    ])
    
    // set variables
    def subject = "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} ${result}"
    def content = '${JELLY_SCRIPT,template="html"}'

    // send email
    if(to != null && !to.isEmpty()) {
        env.ForEmailPlugin = env.WORKSPACE
        emailext mimeType: 'text/html',
        body: '${FILE, path="/var/lib/jenkins/workspace/springboot/report.html"}',
        subject: currentBuild.currentResult + " : " + env.JOB_NAME,
        to: to, attachLog: true
    }
}

pipeline {
  agent any

	environment {
		PROJECT_ID = 'tech-rnd-project'
                CLUSTER_NAME = 'wordpress-cluster'
                LOCATION = 'us-central1-a'
                CREDENTIALS_ID = 'kubernetes'	
	}
	
    stages {
	    stage('Scm Checkout') {
		    steps {
			    	checkout scm
		    }
	    }
	    

	    stage('Build Docker Image') {
		    steps {
			    sh 'whoami'
			    sh 'sudo chmod 777 /var/run/docker.sock'
			    sh ' sudo apt update'
			    sh 'docker build -t gcr.io/tech-rnd-project/wp-app .'    
		    }
	    }
	    
	    stage("Push Docker Image") {
		    steps {
			    script {
				echo "Push Docker Image"
				sh 'gcloud auth configure-docker'
				sh "sudo docker push gcr.io/tech-rnd-project/wp-app:latest"
				
				sh 'curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl'

				sh "chmod +x kubectl"

				sh "sudo mv kubectl \$(which kubectl)"    
			    }
		    }
	    }
	    
	    stage('Deploy to K8s') {
		    steps{
			    echo "Deployment started ..."
			    sh 'ls -ltr'
			    sh 'pwd'
				
				echo "Start deployment of deployment.yaml"
				step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'k8', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
			    	echo "Deployment Finished ..."
			    sh '''
			    '''
			    
		    }
	    }
	    
	     stage('Zap Installation') {
                    steps {
				    
			sh 'docker rm -f owasp'   
                        sh 'echo "Hello World"'
			sh '''
			    echo "Pulling up last OWASP ZAP container --> Start"
			    docker pull owasp/zap2docker-stable
			    
			    echo "Starting container --> Start"
			    docker run -dt --name owasp \
    			    owasp/zap2docker-stable \
    			    /bin/bash
			    
			    
			    echo "Creating Workspace Inside Docker"
			    docker exec owasp \
    			    mkdir /zap/wrk
			'''
			    }
		    }
	    stage('Scanning target on owasp container') {
             steps {
                 script {
			 sh '''
		         sleep 10
			 export USE_GKE_GCLOUD_AUTH_PLUGIN=True
			 gcloud container clusters get-credentials wordpress-cluster --zone us-central1-a --project tech-rnd-project
			 kubectl get pods	
			 kubectl get service wordpress-app > intake.txt
			
			
				awk '{print \$4}' intake.txt > extract.txt
                        '''
			IP = sh (
        			script: 'grep -Eo "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" extract.txt > finalout.txt && ip=$(cat finalout.txt) && aa="http://${ip}:80" && echo $aa',
        			returnStdout: true
    			).trim()
    			echo "Your IP is: ${IP}"
	    	     
			 
                       scan_type = "Baseline"
                       echo "----> scan_type: $scan_type"
			 
			
		       
			 
                       if(scan_type == "Baseline"){
                           sh """
                               docker exec owasp \
                               zap-baseline.py \
                               -t ${IP} \
                               -r report.html \
                               -I
                           """
                       }
                      
                       else{
                           echo "Something went wrong..."
                       }
			sh '''
				docker cp owasp:/zap/wrk/report.html ${WORKSPACE}/report.html
				echo ${WORKSPACE}
				docker stop owasp
                     	docker rm owasp
			'''
			SendEmailNotification("SUCCESSFUL")
				    
		  }
	     }
	}
    }
	
    }

