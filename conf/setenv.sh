#!/bin/bash
HOSTNAME=`hostname -s`
ADMIN_USER=${ADMIN_USER:-admin}
ADMIN_PASS=${ADMIN_PASSWD:-admin}
MAX_UPLOAD_SIZE=${MAX_UPLOAD_SIZE:-52428800}

cat << EOF > /usr/local/tomcat/conf/tomcat-users.xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
<user username="${ADMIN_USER}" password="${ADMIN_PASSWD}" roles="admin-gui,manager-gui"/>
</tomcat-users>
EOF
wget -O /usr/local/tomcat/lib/CACERT.pem ${CACERT_URL}
# &2>/dev/null
keytool -import -trustcacerts -alias ca-cert -file ./lib/CACERT.pem -keystore /etc/ssl/certs/java/cacerts -storepass changeit -noprompt
mkdir -p /usr/local/tomcat/conf/Catalina/localhost/
cp -p /conf/cas.xml /usr/local/tomcat/conf/Catalina/localhost/cas.xml
cp -p /conf/cas-management.xml /usr/local/tomcat/conf/Catalina/localhost/cas-management.xml
cp -p /conf/themes.xml /usr/local/tomcat/conf/Catalina/localhost/themes.xml
