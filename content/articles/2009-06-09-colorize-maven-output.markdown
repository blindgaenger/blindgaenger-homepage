---
title: Colorize Maven Output
tags:
- maven
---

No, Maven still does not support colors. It's a pain to actually _read_ if 
Maven's build was successful or not, instead of easily _seeing_ it. But 
[Johannes Buchner](http://johannes.jakeapp.com/blog/) eased the pain by `sed`ing 
Maven's output to get some basic colors.

You can find his [Maven: Colorized](http://johannes.jakeapp.com/blog/category/fun-with-linux/200901/maven-colorized)
post here. I've' slightly changed the setup as you can read below.

Put this in your `~/.bashrc` and reload. There is also a second alias `maven` to 
the original version, just in case.

{{bash
# Colorize Maven Output
color_maven() {
  $MAVEN_HOME/bin/mvn $* | sed -e 's/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/ESC[1;32mTests run: \1ESC[0m, Failures: ESC[1;31m\2ESC[0m, Errors: ESC[1;33m\3ESC[0m, Skipped: ESC[1;34m\4ESC[0m/g' \
    -e 's/\(\[WARN\].*\)/ESC[1;33m\1ESC[0m/g' \
    -e 's/\(\[INFO\].*\)/ESC[1;34m\1ESC[0m/g' \
    -e 's/\(\[ERROR\].*\)/ESC[1;31m\1ESC[0m/g'
}
alias mvn=color_maven
alias maven=$MAVEN_HOME/bin/mvn
}}

Please note, this script is pointing to `$MAVEN_HOME`, the original script 
does not. So you may set your `PATH` first.

{{bash
export MAVEN_HOME=/opt/maven
export PATH=$MAVEN_HOME/bin:$PATH
}}

Done!
