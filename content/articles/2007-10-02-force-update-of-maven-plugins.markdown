---
layout: post
title: Force update of Maven plugins
tags:
- maven
---

# Problem

The plugin `org.apache.maven.plugins:maven-resources-plugin` does not exist or 
no valid version can be found.

# Solution

Force an update with `-U`. If you only use `-U` build will usually fail, but the 
modules will be updated anyway. So combine it with your other goals.

{% highlight bash %}
$ mvn -U
$ mvn -U clean
{% endhighlight %}



