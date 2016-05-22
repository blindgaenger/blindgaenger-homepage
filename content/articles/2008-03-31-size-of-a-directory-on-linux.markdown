---
layout: post
title: Size of a directory on Linux
tags:
- linux
- shell
---

Disk usage `du` with size `-s` in a human readable `-h` format for the current directory.
{% highlight bash %}
du -s -h .
{% endhighlight %}

For all sub-dirs `./*`, sorted by size (numeric `-n`). Don't use `-h`, otherwise 10M would be before 1G.
{% highlight bash %}
du -s ./* | sort -n
{% endhighlight %}

[http://www.lifeaftercoffee.com/2006/04/04/how-big-is-that-unix-directory/](http://www.lifeaftercoffee.com/2006/04/04/how-big-is-that-unix-directory/)
