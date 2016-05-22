---
layout: post
title: Run a main method with Maven
tags:
- maven
- test
- java
---

Use maven's `exec` plugin (<http://mojo.codehaus.org/exec-maven-plugin/>):

{{bash
$ mvn exec:java -Dexec.mainClass=net.blindgaenger.toolbox.ssh.Main -Dexec.args="1154"
}}

