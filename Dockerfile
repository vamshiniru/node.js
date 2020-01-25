FROM httpd
RUN apk --no-cache add curl
VOLUME /tmp
COPY  /target/demo3-0.0.1-SNAPSHOT.war app.war
