---
layout: post
title: Check for rootkits and run antivirus scanner on Ubuntu
tags:
- rootkits
- antivirus
- ubuntu
---

One of the main reasons for switching to Linux was a rootkit hitting my Windows 
installation. This was the best time to play with Ubuntu (before reinstalling 
Windows again, as I thought). I stayed, but since then I run these commands 
regularly. :)

# [Rootkit Hunter](http://rkhunter.sourceforge.net/)

Although this shouldn't be the main reason to use it, but Rootkit Hunter has a 
very good command line interface. Your shell should support colors to enjoy it!

{% highlight bash %}
sudo apt-get install rkhunter
sudo rkhunter --versioncheck
sudo rkhunter --update --propupd
sudo rkhunter --check
{% endhighlight %}


# [chkrootkit](http://www.chkrootkit.org/)

Actually chkrootkit seems to check the same stuff as rkhunter. But the
downside is the missing update command.

{% highlight bash %}
sudo apt-get install chkrootkit
sudo chkrootkit -V
sudo chkrootkit
{% endhighlight %}

# [Clam AntiVirus](http://www.clamav.net/)

Get new virus definitions with freshclam . But apt-get should have installed an 
update-deamon in /etc/init.d/clamav-freshclam, so this shouldn't be necessary.

{% highlight bash %}
sudo freshclam 
sudo clamscan --recursive --quiet --bell --stdout /home >/tmp/clamscan.log
less /tmp/clamscan.log
{% endhighlight %}

Yep, there are GUIs for clamav out there. Then try 
[clamtk](http://clamtk.sourceforge.net/) if you need one.

