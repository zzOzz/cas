FROM tomcat:jre8
RUN apt-get -qq update
RUN apt-get -qq upgrade
RUN apt-get install -y libtcnative-1 locales vim curl
RUN locale-gen fr_FR.UTF-8
RUN keytool -genkey -noprompt \
 -alias tomcat \
 -dname "CN="$(hostname)",C=FR" \
 -keystore /root/.keystore \
 -storepass changeit \
 -validity 3650 \
 -keypass changeit
ADD conf/setenv.sh /usr/local/tomcat/bin/
RUN sed -i 's/8443/443/g' /usr/local/tomcat/conf/server.xml
RUN sed -i '84d' /usr/local/tomcat/conf/server.xml
RUN sed -i '87d' /usr/local/tomcat/conf/server.xml
RUN rm -fr /usr/local/tomcat/webapps/ROOT
RUN rm -fr /usr/local/tomcat/webapps/examples
RUN rm -fr /usr/local/tomcat/webapps/docs
ADD cas.war /usr/local/tomcat/webapps/cas.war
ADD cas-management.war /usr/local/tomcat/webapps/cas-management.war
ADD conf /conf
VOLUME /conf
EXPOSE 443
#java debug
EXPOSE 8888
