node {

	 env.PATH="${tool 'M3'}/bin:${env.PATH}"
      
     stage('checkout') {
         checkout scm
     }
     
     stage ('clean') {
         sh "mvn clean"
     }

     stage('packaging  sit'){
         sh "mvn clean package -DskipTests -Psit"
         step([$class: 'ArtifactArchiver', artifacts: '**/target/**.jar'])
	 }
	 
	 stage('deplay sit'){
	     try {
		      sh 'anible-playbook sit-node1.yml'
		 }catch(err){
		     throw err 
		 }
	 }
}	 
	 