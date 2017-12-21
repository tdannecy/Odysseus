---
layout: post
title: Delayed Session Reload — Odysseus Development Blog
posttitle: Faster Startup with Delayed Loading of Pages
header: 21st December 2017 — Adrian Cochrane
date: 2017-12-21 15:38:56 1300
categories: features
---

I just added a nice new feature to improve Odysseus's startup performance, while it will still reopen the pages you had open last time you used Odysseus now it will hold off on loading those webpages. That is Odysseus now has a blazingly fast startup which remembers where you left off, it's just what [the doctor ordered](https://elementary.io/docs/human-interface-guidelines#first-launch-experience).

This was implemented by having tabs load an internal page ([odysseus:restore](odysseus:restore)) instead of the actual content for their page, and by having JavaScript in that internal page decide when to perform the actual load. 

And once again this is just what you get for choosing a browser designed specifically for elementary OS. 
