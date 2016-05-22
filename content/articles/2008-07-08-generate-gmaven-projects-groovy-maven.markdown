---
layout: post
title: Generate GMaven projects (Groovy & Maven) 
tags:
- groovy
- maven
---

This is more like a cheatsheet for me. But I've used the original [GMaven docs](http://groovy.codehaus.org/GMaven+-+Building+Groovy+Projects)
if you miss something.

Start generation from the project folder using maven itself:

{% highlight bash %}
mvn archetype:generate -DarchetypeGroupId=org.codehaus.groovy.maven.archetypes -DarchetypeArtifactId=gmaven-archetype-basic
{% endhighlight %}

Answer some questions about the new artifact:

{% highlight bash %}
[INFO] Scanning for projects...
[INFO] Searching repository for plugin with prefix: 'archetype'.
[INFO] ------------------------------------------------------------------------
[INFO] Building Maven Default Project
[INFO]    task-segment: [archetype:generate] (aggregator-style)
[INFO] ------------------------------------------------------------------------
[INFO] Preparing archetype:generate
[INFO] No goals needed for project - skipping
[INFO] Setting property: classpath.resource.loader.class => 'org.codehaus.plexus.velocity.ContextClassLoaderResourceLoader'.
[INFO] Setting property: velocimacro.messages.on => 'false'.
[INFO] Setting property: resource.loader => 'classpath'.
[INFO] Setting property: resource.manager.logwhenfound => 'false'.
[INFO] [archetype:generate]
[INFO] Generating project in Interactive mode
[WARNING] Specified archetype not found.
[INFO] No archetype defined. Using maven-archetype-quickstart (org.apache.maven.archetypes:maven-archetype-quickstart:1.0)
Choose archetype:
1: internal -> appfuse-basic-jsf (AppFuse archetype for creating a web application with Hibernate, Spring and JSF)
...
10: internal -> maven-archetype-j2ee-simple (A simple J2EE Java application)
11: internal -> maven-archetype-marmalade-mojo (A Maven plugin development project using marmalade)
12: internal -> maven-archetype-mojo (A Maven Java plugin development project)
13: internal -> maven-archetype-portlet (A simple portlet application)
14: internal -> maven-archetype-profiles ()
15: internal -> maven-archetype-quickstart ()
16: internal -> maven-archetype-site-simple (A simple site generation project)
17: internal -> maven-archetype-site (A more complex site project)
18: internal -> maven-archetype-webapp (A simple Java web application)
...
44: internal -> cocoon-22-archetype-webapp ([http://cocoon.apache.org/2.2/maven-plugins/])
Choose a number:  (1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/42/43/44) 15: :
[INFO] artifact org.apache.maven.archetypes:maven-archetype-quickstart: checking for updates from maven-archetype-quickstart-repo
Define value for groupId: : net.blindgaenger
Define value for artifactId: : test.gmave
Define value for version:  1.0-SNAPSHOT: : 1.0-SNAPSHOT
Define value for package: : net.blindgaenger.test.gmaven
Confirm properties configuration:
groupId: net.blindgaenger
artifactId: test.gmaven
version: 1.0-SNAPSHOT
package: net.blindgaenger.test.gmaven
 Y: : Y
[INFO] ----------------------------------------------------------------------------
[INFO] Using following parameters for creating OldArchetype: maven-archetype-quickstart:RELEASE
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: groupId, Value: net.blindgaenger
[INFO] Parameter: packageName, Value: net.blindgaenger.test.gmaven
[INFO] Parameter: package, Value: net.blindgaenger.test.gmaven
[INFO] Parameter: artifactId, Value: test.gmaven
[INFO] Parameter: basedir, Value: E:\Projects\Hydra\Workspace\xxx
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] ********************* End of debug info from resources from generated POM ***********************
[INFO] OldArchetype created in dir: E:\Projects\Hydra\Workspace\xxx\test.gmaven
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESSFUL
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 49 seconds
[INFO] Finished at: Tue Jul 08 13:23:54 CEST 2008
[INFO] Final Memory: 8M/15M
[INFO] ------------------------------------------------------------------------
{% endhighlight %}


This generates the following files and `pom.xml`:

{% highlight bash %}
<projects>/
|
+- test.gmaven/
   |
   +- pom.xml
   |
   +- src/main/java/
   |  |
   |  +- net/blindgaenger/test.gmaven
   |     |
   |     +- App.java
   |  
   +- src/main/test/
      |
      +- net/blindgaenger/test.gmaven
         |
         +- AppTest.java
{% endhighlight %}


{% highlight xml %}
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>net.blindgaenger</groupId>
  <artifactId>test.gmaven</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>test.gmaven</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>
{% endhighlight %}


