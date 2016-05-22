---
layout: post
title: Eclipse Ganymede startup problem in Ubuntu
tags:
- eclipse
- swt
- xulrunner
- ubuntu
---

I installed Ganymede on Ubuntu, but it crashed on startup: 

> org.eclipse.swt.SWTError: XPCOM error

Since a while SWT is able to use Mozilla as browser, that's what the XPCOM is 
about. The problem is SWT trying to use my Mozilla installation and fails.The 
[Eclipse FAQ](http://www.eclipse.org/swt/faq.php#browserlinux) describes 
some settings for linux browsers. But this did the trick for me.

Install a separate version of `xulrunner`:

{% highlight bash %}
sudo apt-get install xulrunner
{% endhighlight %}

Append this to `$ECLIPSE_HOME/eclipse.ini`:

{% highlight bash %}
-Dorg.eclipse.swt.browser.XULRunnerPath=/usr/lib/xulrunner/xulrunner
{% endhighlight %}

Done!

