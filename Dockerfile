FROM jboss/wildfly
MAINTAINER Bastiaan Schaap, Siteminds B.V. <http://github.com/Siteminds>
USER root
COPY epel-apache-maven.repo /etc/yum.repos.d/
RUN yum install -y apache-maven && yum clean all
RUN mkdir -p /tmp/src && chown -R jboss:jboss /tmp/src
USER jboss
RUN /opt/jboss/wildfly/bin/add-user.sh --silent admin admin
WORKDIR /tmp/src/
COPY pom.xml /tmp/src/
RUN mvn verify clean --fail-never
COPY . /tmp/src
RUN mvn package
RUN cp target/wildfly-helloworld.war /opt/jboss/wildfly/standalone/deployments/
EXPOSE 8080