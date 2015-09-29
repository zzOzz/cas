#DockerFile for JASIG CAS
Jasig Cas 4.1 image with cas-management

##Prerequisites

  * docker
  * JVM & maven (war building)
  * docker-compose
  * ssl certificates

##image build
mvn clean package;docker-compose rm -f;docker-compose build;docker-compose up

##sample config
You can find sample config in sample folder, it use:
 * SQLSERVER_USER_DATABASE for authentication (SHA1 password storage)
 * LDAP_USER Authentication
 * MYSQL Ticket & Service Storage (shared with cas-management application)
 * Theme customization folder


Copy this folder in the /conf folder.

~~~
#Copy this folder in the /conf folder.
cp -pr ./sample/conf ./conf
#Copy sample docker-compose file
cp docker-compose.yml.sample docker-compose.yml
#Edit the file
~~~

##docker-compose.yml
 You can adapt the file with your own config.

  * VIRTUAL_HOST -> the url used by your cas server
  * ADMIN_USER -> tomcat manager username (https://cas.my_domain.com/management)
  * ADMIN_PASSWD -> tomcat manager passwd
  * CACERT_URL -> URL where your own Certification Authority for your ldaps server can be downloaded
  * /Users/vincent/Documents/my_certificate_folder -> location of the folder that store the ssl certificate of your server (see (https://github.com/jwilder/nginx-proxy))
