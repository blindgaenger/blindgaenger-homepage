---
layout: post
title: Subclipse Update causes SVN Log entry missing name attribute
tags:
- eclipse
- svn
---

# Problem

During update of Subclipse to version 1.2.0 the following error occured:

{% highlight bash %}
svn: Log entry missing name attribute (entry 'modify-wcprop' for directory ...
{% endhighlight %}

# Solution

[http://svn.haxx.se/users/archive-2007-02/0618.shtml](http://svn.haxx.se/users/archive-2007-02/0618.shtml)

> I look at the log file located in .svn and one of the modify-wcprop entry was
> missing the name attribute. 

* add `name=""` to the XML file
* Cleanup and refresh the project in Eclipse

