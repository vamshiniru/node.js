FROM hhtpd
RUN apk --no-cache add curl
VOLUME /tmp
COPY  /target/demo3-0.0.1-SNAPSHOT.jar app.war
