FROM tomcat:8
ADD target/java-example.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]