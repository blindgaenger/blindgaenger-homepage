---
layout: post
title: Run a single test-case with Maven
tags:
- maven
- test
- java
---

Use the name with wildcards ()<http://maven.apache.org/plugins/maven-surefire-plugin/examples/single-test.html>):
{{bash
$ mvn -Dtest=Server*Test test
}}

