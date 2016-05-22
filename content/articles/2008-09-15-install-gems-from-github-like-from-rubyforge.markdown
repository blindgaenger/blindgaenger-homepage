---
layout: post
title: Install gems from GitHub like from RubyForge
tags:
- ruby
- rubygems
- github
---

Install gems from GitHub directly without specifying the source, just like you 
would if you were installing them from RubyForge.

Update rubygems to 2.1
{% highlight bash %}
$ sudo gem update --system
{% endhighlight %}

Add the sources to rubygems, so the gem names can be resolved to a source url.
{% highlight bash %}
$ sudo gem sources -a http://gems.github.com
{% endhighlight %}

Try it with a gem on GitHub.
{% highlight bash %}
$ sudo gem install simplificator-rwebthumb
{% endhighlight %}

Links
[http://github.com/blog/97-github-loves-rubygems-1-2](http://github.com/blog/97-github-loves-rubygems-1-2)
[http://gems.github.com/](http://gems.github.com/)

