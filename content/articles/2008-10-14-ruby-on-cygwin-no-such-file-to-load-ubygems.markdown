---
layout: post
title: Ruby on Cygwin - No such file to load -- ubygems
tags:
- ruby
- rubygems
- cygwin
---

[http://bparanj.blogspot.com/2007/04/ruby-no-such-file-to-load-ubygems.html](http://bparanj.blogspot.com/2007/04/ruby-no-such-file-to-load-ubygems.html)

If you download Ruby in Cygwin, it requires rubygems without installing them 
before.
{% highlight bash %}
$ echo $RUBYOPT
-rubygems
{% endhighlight %}

But this option even prevents Rubygems to be installed.
{% highlight bash %}
/tmp/rubygems-1.3.0$ ruby setup
Ruby: No such file to load -- ubygems (LoadError)
{% endhighlight %}

Just unset that variable and then you should be good to go.
{% highlight bash %}
$ export RUBYOPT=
$ ruby setup
...
{% endhighlight %}

