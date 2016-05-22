---
layout: post
title: Timestamp in Oracle
tags:
- sql
- oracle
---

[Oracle SQL Developer](http://www.oracle.com/technology/products/database/sql_developer/index.html)
application doesn't know how to handle invalid timestamps, so I set them to 
unixtime 0 instead of 0.

{{sql
update merchants
set updated_at = timestamp('1970-01-01 10:00:00')
where updated_at = 0
;
}}

