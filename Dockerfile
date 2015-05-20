FROM jboss/wildfly
MAINTAINER Bastiaan Schaap, Siteminds B.V. <http://github.com/Siteminds>
USER root
ADD epel-apache-maven.repo /etc/yum.repos.d/
RUN yum install -y apache-maven && yum clean all
ADD . /tmp/src/
WORKDIR /tmp/src/
RUN mvn package
RUN cp target/wildfly-helloworld.war /opt/jboss/wildfly/standalone/deployments/ && rm -rf /tmp/src
USER jboss
RUN /opt/jboss/wildfly/bin/add-user.sh --silent admin admin
EXPOSE 8080
