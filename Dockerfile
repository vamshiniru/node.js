FROM tomcat
#RUN apk --no-cache add curl
VOLUME /tmp
COPY  /target/WebApp.war webapps
