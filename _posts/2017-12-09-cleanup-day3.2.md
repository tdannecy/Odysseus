---
layout: post
title: 9th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 3 Part 2"
header: 9th December 2017 — Adrian Cochrane
date: 2017-12-09 22:49:45 1300
categories: cleanup1.0
---

Another class cleaned up in the second part of the day, this time `WebTab`. There I moved concerns out into Persistance and other "Traits", and continued splitting the constructor into seperate methods & Widgets. While I was at it I moved to using my own UserAgent string as I've been struggling to keep up to date with Safari's, and I corrected the behaviour of the find toolbar. 

I'm not particularly happy about having my own user agent, as it increases the browser fingerprint I expose to websites just so they can annoy me about using an unsupported browser despite their sites being fully functional. This browser fingerprint in turn allows for very intrusive tracking which is hard to correct. Heck if there's one thing I'd want the W3C to tackle it'd be deprecate user agent strings. 

## What Are Traits
Traits, in the Odysseus codebase are loosely coupled pieces of code which adds new behaviours to WebViews. They basically ammount to hardcoded browser plugins, except they can't be enabled or disabled. 
