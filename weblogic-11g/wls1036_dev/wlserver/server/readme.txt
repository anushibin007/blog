Getting Started with WebLogic Server 10.0

BEA WebLogic Server® 10 

	*  Java EE 5 compatible including EJB 3.0
	*  Rock Solid Foundation for enterprise applications and SOA
	*  Relentless Focus on Uptime
	*  Blended Application Development
	*  Administrative Productivity
	*  High Performance
	*  Extended Industry Solutions

  Operations, Administration, and Management

    Administration Console 
	*  WebLogic Server release 10.0 introduces the following changes to the Administration Console: 

	*  You can now record your configuration actions in the Administration Console as 
	   a series of WebLogic Scripting Tool (WLST) commands and then use WLST to run the 
	   commands. For more information, see "Record WLST Scripts" in WebLogic Server 
	   Administration Console Help. 

	   The Administration Console adds a preference that specifies the number of seconds 	
	   that the Administration Server waits for a management operation to complete. Almost 
	   all actions in the Administration Console - including logging in - require the 
	   Administration Console to connect to one or more MBean servers and invoke MBean server methods. 
	   This timeout preference specifies how long the Administration Console will wait for the 
	   method invocation to complete. If the invocation does not complete (return) within the timeout 
	   period, the Administration Console abandons its invocation attempt. 

	*  Administration Console extensions must be packaged as a WAR file instead of a JAR file. 
	   Many console-extension features are unsupported unless you follow the packaging and archiving 
	   conventions of Web applications. For example, if include a properties bundle in your console 
	   extension, the Administration Console will not deploy the bundle properly unless it is located
	   within your console extension's root-dir/WEB-INF/classes directory and unless the extension is 
	   archived as a WAR file. For more information, see Archiving and Deploying Console Extensions in 
	   Extending the Administration Console.


    SNMP 
        *  WebLogic Server now supports the SNMPv3 protocol in addition to the SNMPv1 and SNMPv2 protocols.

           In the SNMPv3 protocol, both SNMP agent and manager must encode identical credentials in their 
           PDUs for the communication to succeed. For additional security and flexibility, WebLogic Server 
           SNMP agents map SNMP credentials to a WebLogic Server user. The WebLogic Server security realm 
           authenticates the user and authorizes access to monitoring data in the domain.

        *  You can now create multiple SNMP agents in a domain and target the agents to WebLogic Server 
           instances.

        *  WebLogic Server SNMP agents now communicate through a TCP port in addition to a UDP port.

        *  You can now use SNMP to monitor MBeans that you create and register (custom MBeans).

        *  The SNMP command-line utility that is documented in the WebLogic SNMP Agent Command-Line Reference
           chapter of WebLogic Server Command Reference is deprecated as of WebLogic Server 10.0. Instead, 
           use the SNMP command-line utility that is documented in the WebLogic SNMP Command-Line Utility 
           chapter of WebLogic SNMP Management Guide.

        *  You can now change configuration options for SNMP agents—including port numbers—without needing to
           restart WebLogic Server. Before this release, most changes required a restart.


    JMX 
        In WebLogic Server 10.0, the JMX implementation supports the jmx.remote.x.request.waiting.timeout 
        environment parameter. (The JMX Remote API 1.0 specification states that support for this parameter
        is optional.) Use this option to specify the number of milliseconds that your JMX client waits for
        the invocation of an MBean-server method to return. If a method does not return by the end of the
        timeout period, the client moves to its next set of instructions. By default, a client waits 
        indefinitely for a method to return; if the MBean server is unable to complete an invocation, the
        JMX client will hang indefinitely. 
  

    JDBC and JTA 
        *  Improved JDBC Connection Monitoring and Testing

           Prior to this release, WebLogic Server relied on JDBC drivers to properly handle, or at 
           least respond in a timely way to any DBMS connectivity failures. For certain network failure 
           conditions, WebLogic Server was not able to determine a connection failure until the TCP/IP 
           timeout expired. Enhanced connection health monitoring and testing for connections where 
           connectivity is suspected to be broken now minimizes or eliminates the delay in delivering 
           a healthy connection from within the connection pool or within the Multi Data Source. 

        *  Oracle Fast Connection Failover Support

           WebLogic Server supports Oracle Fast Connection Failover. This feature offers a 
           driver-independent way for your JDBC application to take advantage of the connection 
           failover facilities offered by Oracle 10g. 

        *  MySQL 5.0 Support

           WebLogic Server bundles a driver for MySQL 5.0.x and supports MySQL 5.0.x.

        *  JTA 1.1 Support

           WebLogic Server is JTA 1.1 compliant, including standard support for looking up the 
           TransactionSynchronizationRegistry object in JNDI using 
           java:comp/TransactionSynchronizationRegistry. BEA extends support by providing two additional 
           global JNDI names: javax/transaction/TransactionSynchronizationRegistry and
           weblogic/transaction/TransactionSynchronizationRegistry.

        *  Automatic Migration of the Transaction Recovery Service

           The WebLogic Server migration framework allows an administrator to configure the JTA 
           Transaction Recovery Service (TRS) so that it is automatically migrated from the current 
           unhealthy hosting server to a healthy active server with the help of WebLogic Server health 
           monitoring capabilities. This capability improves the availability of the JTA TRS in a cluster
           because it can be quickly restarted on a redundant server should the host server fail.


    Messaging 
        *  Migration of JMS-Related Services

           The WebLogic Server migration framework allows an administrator to configure migratable 
           targets so that certain JMS-related services can be migrated from the current unhealthy hosting
           server to a healthy active server. High availability is achieved by migrating a migratable 
           target from one clustered server to another when a problem occurs on the original server. You
           can also manually migrate a migratable target for scheduled maintenance.

           In addition to JMS servers, WebLogic Server supports service-level migration for the following
           JMS-related services:

           * Store-and-Forward (SAF) agents
           * Path services
           * Custom persistent stores (file-based or JDBC-accessible)

        *  JMS ${APPNAME} Parameter to Create Unique Runtime JNDI Names for JMS Resources

           In a clustered environment, JMS resources, such as connection factories, standalone destinations,
           and distributed destinations, can now substitute in a unique qualifier to a JNDI name at runtime
           to make the global JNDI names unique for those resources. The JMS ${APPNAME} parameter is 
           replaced at runtime with the application name of the host application being merged to the 
           application library. 


    Deployment
        *  Production redeployment is now fully supported for Web Services, both stateless and stateful 
           services that use more advanced features such as conversations and reliable messaging. 

        *  You can specify a grace period (in seconds) for processing of RMI client requests when retiring
           or gracefully shutting down an application. The work manager of a server instance accepts and
           schedules RMI calls until the grace period expires without a receiving new RMI client request.


    Security Framework
    	*  Single sign-on support
      	   WebLogic Server supports single sign-on with Security Assertion Markup Language (SAML) and, on 
	   Windows desktops, single sign-on with the Simple and Protected Negotiate (SPNEGO) protocol. 

    	*  Support for the Java Authorization Contract for Containers (JACC)JACC can replace the EJB and 
	   Servlet container deployment and authorization provided by WebLogic Server.
 
   	*  New security providers
           WebLogic Server provides new security providers for LDAP X509 Identity Assertion, Windows NT 
	   authentication, DBMS authentication, CertPath provider, and CertPath registry.

   	*  Enhancements to security providers
      	   WebLogic Server adds performance enhancements to the WebLogic Credential Mapper, WebLogic 
	   Authentication Provider, WebLogic Identity Assertion Provider, and the WebLogic Authorization
      	   Provider. 


    Enterprise Web Services 
    	*  As part of the Web Services features in JEE5 we have included support for:
	   JAX-WS 2.0 (Web Services API)
	   JAXB 2.0
	   SAAJ 1.3
	   WSEE 1.2
	   JSR-181 (Web Services Annotations)
	   MTOM/XOP (for both JAX-WS and JAX-RPC)

    Support for Service-Oriented Architectures (SOA)
    	*  The JAX-RPC based SOAP processor has continued to evolve from our WLS 9.2 release and provides 
	   broad support for key WS-* standards such as:
	   WS-Security 1.1
	   WS-Security Policy 1.2
	   WS-SecureConversation
	   WS-Reliable Messaging
	   WS-Addressing
    
      	   WebLogic Server supports SOA by providing solid, enterprise-ready
      	   features such as store-and-forward, which provides for automatic
      	   retry of failed messages,.
    	*  True asynchronous messaging support for conversational applications
      	   WebLogic Server supports asynchronous messaging with Reliable
      	   SOAP Messaging, conversational Web Services, callbacks, and addressing. 

    	*  Improved XML processing performance and ease of use
       	   Data-binding feature enables you to create a Java
      	   interface that mirrors an XML schema or an XML schema that mirrors
           a Java interface.  WebLogic Server also supports the Streaming API
      	   for XML (StAX), a bi-directional API for reading and writing XML.
      

Learn About WebLogic Server 10.0

  Resources Available with your WebLogic Server Installation 
    * Code Examples and Sample Applications
    * Fast Track Deployment and Administrator Guide 
      Learn how to quickly deploy Java EE applications and access system
      administration tools.
    * Avitek Medical Records Sample Application
      The Avitek Medical Records application is an educational tool for
      all levels of J2EE developers. It showcases the use of each J2EE
      component, and illustrates best practice design patterns for
      component interaction and client wdevelopment. MedRec also
      illustrates best practices for developing and deploying
      applications with WebLogic Server. Complete source code and
      documentation is available for this application.

      To launch the Medical Records Application, first shut down the
      current WebLogic Server instance using the *Shut Down Server
      *button in the top right corner of this page. Then select *Start
      Medical Records Server* from the Windows Start menu. or run the
      startWebLogic.sh script from the
      /BEA_HOME//weblogic100/samples/domains/medrec directory, where
      /BEA_HOME/ is the directory containing your WebLogic Server
      installation.


Support for Multiple Programming Models

     WebLogic Server 10.0 now fully supports the Java Enterprise Edition
     (Java EE) 5.0 specification including support for the following APIs:

    * Java EE 5.0, including:
          o Enterprise JavaBeans (EJB) 3.0
          o Servlet 2.4
          o Java ServerPages (JSP) 2.0
          o Java Database Connectivity (JDBC) 3.0
          o Java Connector Architecture (JCA) 1.5
          o Java Messaging Service (JMS) 1.1
          o Java Management Extensions (JMX) 1.2
	JAX-WS 2.0 (Web Services API)
	JAXB 2.0
	SAAJ 1.3
	WSEE 1.2
	JSR-181 (Web Services Annotations)
    * Struts
    * Beehive (Apache)
    * Spring


Copyright 2007, Oracle Inc.


