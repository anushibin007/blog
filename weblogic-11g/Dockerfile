FROM ubuntu

### I like to use bash always
SHELL ["/bin/bash", "-c"]

### Environment variables start
ENV WORKDIR /opt

ENV SCRIPTS_HOME $WORKDIR/scripts
ENV JAVA_HOME $WORKDIR/jdk1.6.0_30
ENV MW_HOME $WORKDIR/wls
ENV DOMAIN_HOME $MW_HOME/user_projects/base_domain

ENV PATH $JAVA_HOME/bin:$PATH

ENV CMD_WLST $JAVA_HOME/bin/java $JAVA_OPTIONS -Xmx1024m -XX:MaxPermSize=128m weblogic.WLST
### Environment variables start end

WORKDIR $WORKDIR

### Copy stuff
COPY wls1036_dev $MW_HOME
COPY jdk-6u30-linux-x64.bin $WORKDIR
COPY scripts $SCRIPTS_HOME

### Pre-req
RUN chmod -R a+x $SCRIPTS_HOME/*.sh
RUN chmod -R a+x $MW_HOME/*.sh
RUN chmod a+x $WORKDIR/*

### Install JDK
RUN $WORKDIR/jdk-6u30-linux-x64.bin

### Configure WLS
RUN source $MW_HOME/configure.sh
RUN $SCRIPTS_HOME/createDomain.sh

### Expose the Weblogic HTTP port
EXPOSE 7001

ENTRYPOINT $DOMAIN_HOME/startWebLogic.sh