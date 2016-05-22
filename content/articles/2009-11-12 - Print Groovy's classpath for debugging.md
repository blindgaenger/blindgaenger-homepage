---
layout: post
title: Print Groovy's classpath for debugging
tags:
- groovy
- eclipse
---

Today I was in need to maintain an old Groovy project. I haven't used Groovy since upgrading to Galileo, so I had to reinstall the [GroovyEclipse Plugin](http://groovy.codehaus.org/Eclipse+Plugin). No problem!

But although my scripts work on the command line, some dependencies were missing in Eclipse. So I used [this little helper](http://paste.lisp.org/display/58599) to print my classpath:

{{
def printClassPath(classLoader) {
  println "$classLoader"
  classLoader.getURLs().each {url->
     println "- ${url.toString()}"
  }
  if (classLoader.parent) {
     printClassPath(classLoader.parent)
  }
}
printClassPath this.class.classLoader
}}

Raised eyebrows, but the problem was easy to solve. Eclipse's classpath variables containes a `GROOVY_HOME` with a trailing slash. Remove the slash and you're good to go.
