FROM openjdk:11-jre
ARG JETTY_HOME=/opt/jetty
ARG USER=jetty
ARG JETTY_VERSION=jetty-distribution/9.4.26.v20200117
ARG JETTY_VERSION2=jetty-distribution-9.4.26.v20200117
#https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.26.v20200117/jetty-distribution-9.4.26.v20200117.tar.gz
ARG JETTY_TZ=https://repo1.maven.org/maven2/org/eclipse/jetty/$JETTY_VERSION/$JETTY_VERSION2.tar.gz
ARG JETTY_HOME=/opt/jetty
ARG TEMP=/tmp
ARG WAR_SOURCE=build/libs/webdemo.war
RUN apt update


RUN mkdir -p $JETTY_HOME
ADD $JETTY_TZ $TEMP
RUN tar -xvf $TEMP/$JETTY_VERSION2.tar.gz -C $JETTY_HOME
RUN useradd $USER
COPY $WAR_SOURCE $JETTY_HOME/$JETTY_VERSION2/webapps/
RUN chown -R $USER:$USER $JETTY_HOME/$JETTY_VERSION2
EXPOSE 8080
WORKDIR $JETTY_HOME/$JETTY_VERSION2
USER $USER
CMD java -jar start.jar
