---
layout: post
title: Disable Beep on Windows
tags:
- windows
---

Just switched the team/room and it's, oh, so quiet here. Even replaced my
keyboard because the keys were too loud. No Kidding!

* open `regedit`
* find `HKEY_CURRENT_USER\Control Panel\Sound`
* create or edit the Key `Beep` and set it to `no`
* silence!

