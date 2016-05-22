---
layout: post
title: Skip or Ignore Junit tests in Maven
tags:
- maven
- junit
---

We all know, this is a very bad practice. Even the [Surfire plugin](http://maven.apache.org/plugins/maven-surefire-plugin/test-mojo.html)
documentation says that its use is `NOT RECOMMENDED`.

Nevertheless as a good developer you should know these switches. So keep them in 
your mind (in my case on this page), but don't keep them in your repository!

# Command line
{% highlight bash %}
mvn -Dmaven.test.skip=true package
mvn -Dmaven.test.failure.ignore=true package
{% endhighlight %}

# POM file
{% highlight xml %}
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-surefire-plugin</artifactId>
  <configuration>
    <skipTests>true</skipTests>
    <testFailureIgnore>true</testFailureIgnore>
  </configuration>
</plugin>
{% endhighlight %}

