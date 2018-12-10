FROM maven:3.6.0-jdk-8

# Work around a bug in Java 1.8u181 / the Maven Surefire plugin.
# See https://stackoverflow.com/questions/53010200 and
# https://issues.apache.org/jira/browse/SUREFIRE-1588.
ENV JAVA_TOOL_OPTIONS "-Djdk.net.URLClassPath.disableClassPathURLCheck=true"

# Download and install tomcat.
RUN mkdir -p /opt/tomcat
RUN curl "http://apache.mirror.anlx.net/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz" > /opt/tomcat/tomcat.tar.gz
RUN tar -C /opt/tomcat -xf /opt/tomcat/tomcat.tar.gz --strip-components 1
RUN ls /opt/tomcat

# Build Sakai.
COPY . sakai
WORKDIR sakai

# nb. Skip tests to speed up the container build.
RUN mvn install -Dmaven.test.skip=true -DskipTests
RUN mvn sakai:deploy -Dmaven.tomcat.home=/opt/tomcat

# Run Sakai
EXPOSE 8080
WORKDIR /opt/tomcat/bin
CMD ./startup.sh && tail -f ../logs/catalina.out
