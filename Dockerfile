FROM tomcat:8
ADD target/java-example.war /usr/local/tomcat/webapps/
EXPOSE 8090
CMD ["catalina.sh", "run"]