---
layout: post
title: Oracle Sequences
tags:
- sql
- oracle
---

Just talked to our DB admin and asked him to grant me access to alter sequences.
He fired up it's browser, selected the checkbox, looked at me and said: "Didn't 
know this option exists. But what are sequences?" No comment!

{% highlight sql %}
-- new value from sequence
SELECT seq_catalog_profile.NEXTVAL FROM dual;

-- current value from sequence
SELECT seq_catalog_profile.CURRVAL FROM dual;
{% endhighlight %}


