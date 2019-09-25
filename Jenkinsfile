node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get code from a GitHub repository
      git credentialsId: 'github', url: 'https://github.com/durgeshkotadia/java-example.git'
      mvnHome = tool 'M3'
   }
   stage('Maven Build') {
      // Run the maven build
      withEnv(["MVN_HOME=$mvnHome"]) {
         if (isUnix()) {
            sh '"$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore clean package'
         } else {
            bat(/"%MVN_HOME%\bin\mvn" -Dmaven.test.failure.ignore clean package/)
         }
      }
   }
   stage('Docker Build & Push') {
      // Build docker image and push to dockerhub
      echo pwd()
      docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
        def customImage = docker.build("durgeshkotadia/java-example:${env.BUILD_ID}")
        /* Push the container to the custom Registry */
        customImage.push()
      }
   }
   stage('Deploy') {
      sh "docker rm -f java-example || true"
      sh "docker run -d -p 4000:8080 --name java-example durgeshkotadia/java-example:${env.BUILD_ID}"
   }
}
