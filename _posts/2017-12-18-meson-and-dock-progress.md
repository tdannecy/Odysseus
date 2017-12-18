---
layout: page
title: Meson and Dock Progress — Odysseus Development Blog
posttitle: Meson and Dock Progress
header: 18th December 2017 — Adrian Cochrane
date: 2017-12-18 21:45:52 1300
categories: dev
---

Today having gotten through all the refactoring I wanted to do, I rewrote my build files to use [Meson](http://mesonbuild.com/) rather than [CMake](https://cmake.org/) and started to work on some new features to better integrate Odysseus into elementary OS. 

I found it very easy to learn Meson, even though I needed to look at examples of other elementary OS apps which used it. And I feel confident that I will be able to maintain the new build files in the future. However I didn't know Meson well enough to a) get it to run the translation targets alongside the main one and b) get it to run my own script for the rest of the translations. As a quick hack to handle that I wrapped the Meson build files in a [shell script](http://www.freeos.com/guides/lsst/). 

Once I was happy to have moved beyond the burst of refactoring over the past few weeks I moved on to new features. Specifically I drafted code to take advantage of a desktop feature now unique to elementary OS<sup title="The defunct Unity desktop also had it previously.">1</sup>! While I haven't integrated the code into the rest of Odysseus, soon it will show the combined progress of your downloads [ontop of it's app icon](https://elementary.io/docs/human-interface-guidelines#dock-integration) in the dock and notify you when those download have finished. This should be a very convenient feature as it allows viewing this progress at a quick glance from anywhere. 

Features like this are just what you get when using a browser designed specifically for your desktop!
