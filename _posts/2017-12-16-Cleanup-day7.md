---
layout: post
title: 16th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 7"
header: 16th December 2017 — Adrian Cochrane, Bsc
date: 2017-12-16 21:54:01 1300
categories: cleanup1.0
---

I slowed down a fair bit on Odysseus development over the previous 3 days because I was busy graduating in Computer Science. However I did manage get some work done over those days and I finished that chunk of work today. 

It's kind've appropriate that I graduated whilst cleaning up this chunk, Odysseus's templating language "[Prosody](https://alcinnz.github.io/Odysseus/architecture/2017/07/22/prosody.html)", as that component best shows off my competancy at Computer Science. But I also took some of that time to configure Odysseus's branding, much of which can be seen on my website, as well as to fix some very serious problems that showed up (and hid) during my previous refactoring. 

These issues included:

<dl>
  <dt>Opening external URLs started to crash Odysseus</dt>
  <dd>The immediate fix to this was to ensure that the trait which handed URLs off to the system would register event handlers before the error handling code opened a page which was at that moment causing the crash.</dd>
  <dd>Later I fixed that page by switching the broken { % trans % } tag with the { % with % } implementation, but tomorrow I'll have to do something better.</dd>
  <dt>First start appeared to do nothing</dt>
  <dd>The check I used wasn't working, so instead I have first launch triggered by updating the database from version 0.</dd>
  <dt>I've been struggling to delete rows from the database</dt>
  <dd>I've been aware of this problem for a while, and because SQLite's making some complaint foreign keys I simply removed them.</dd>
  <dd>This change is not backwards compatible.</dd>
</dl>

But mostly I focused on numerous small fixes to my "Prosody" templating language, of which highlights include:

* I'm now parsing query strings from the URL into a nice property map.
* Removed several (but not all) unutilized infrastructure.
* Setup infrastructure to more concisely specify escape sequences for the disperate escape styles on the Web<sup title="Why oh why is it that URLs, HTML, and JavaScript all have their different escaping syntax?">1</sup>
* JSON is now exposed to Prosody via a mix of datasource implementations, some of which already existed.
* Slightly more complicate implementations of certains datasources.
* Utilizing GLib APIs better to implement the tags and filters. 
* Implemented the importing of blocks from external templates.

It does make me a bit uneasy to have implemented my own string escaping logic, because I know that if a miss any bit of subtlety will not only allow Odysseus to visually mess up but also for websites to mount an [XSS attack](https://www.owasp.org/index.php/Top_10_2013-A3-Cross-Site_Scripting_(XSS)) via the local SQLite database which tracks their history (and will do so more). So while I've reread this several times, please [check the code out for yourself](https://github.com/alcinnz/Odysseus/blob/master/src/Services/Prosody/lib.vala#L887) to see if I've missed anything. 

---

Next on my list is to finish up with a brand new i18n infrastructure which does not crash, tests for importing and using template "blocks", and enabling those tags. After that I think I have enough time to add a few simple and very elementary features to Odysseus. 
