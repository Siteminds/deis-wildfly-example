FROM jboss/wildfly
MAINTAINER Bastiaan Schaap, Siteminds B.V. <http://github.com/Siteminds>
USER jboss
RUN /opt/jboss/wildfly/bin/add-user.sh --silent admin admin
USER root
ADD epel-apache-maven.repo /etc/yum.repos.d/
RUN yum install -y apache-maven && yum clean all
WORKDIR /tmp/src/
ADD pom.xml /tmp/src/
RUN mvn verify clean --fail-never
ADD . /usr/src/app
RUN mvn verify
USER jboss
RUN cp target/wildfly-helloworld.war /opt/jboss/wildfly/standalone/deployments/
EXPOSE 8080