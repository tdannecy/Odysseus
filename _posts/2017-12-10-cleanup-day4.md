---
layout: post
title: 10th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 4"
header: 10th December 2017 — Adrian Cochrane
date: 2017-12-10 11:59:42 1300
categories: cleanup1.0
---

Today's work is much more along the lines of bugfixing rather than cleaning up my code style. The status bar now behaves correctly in how it reports the find-in-page count and destinations of links, and now all tabs will reliably have a favicon at all times.

In part this fix seems to have come from the WebKitGTK folks as it now seems to capture favicons more reliably than it used to, but at the same time they added security which prevented my from using the usual avenues for setting the favicon in my internal pages. That meant I needed to provide those pages and only those pages with an alternate syntax to use, after which I could remove some old and disperate favicon infrastructure. And finally while WebKitGTK is doing a great job at finding favicons, it can't know the favicon on startup and some sites don't provide favicons, so I added a fallback. 

The trickiest case to deal with on detecting an internal page is load_alternate_html, as the `WebView` provides no indication this method was used. But this was easily solved with a flag on the `WebTab` that's set in the central function for rendering any alternate HTML and reset when load starts. Otherwise it could trivially be implemented as a very simple trait. 

Ofcourse changing the favicon syntax for those pages also required changing all of those pages to use the alternate syntax. This was the most time consuming aspect. 

---

Since I first wrote this post, I organized the widgets into subpackages (header & overlay), performed some code tidies to the downloads bar, and designed a better downloads bar experience. 

Before I organized the widgets, I found they were just starting to sprawl. Now that I've added the `header` and `overlay` the cohesion of those packages improved. 

The code tidies mostly involved assuming translators of my chrome understand C format strings and using a more concise syntax for lambdas where possible. But I also:

* moved some methods into a more appropriate class (singleton/setup methods from `Download` to `DownloadSet`),
* removed some dead code,
* utilized existing abstractions to clear away file prompt boilerplate. 
* and moved away from the deprecated `Gtk.Box` to `Gtk.Grid` in the downloads bar. 

And finally the upgraded downloads experience

* Clears away completed downloads from closed downloads bars. 
* Organizes downloads into dated folders (big-endian so lexicographic ordering works on it, save for a [Y10K bug](http://longnow.org/clock/)).
* Links to that dated folder in the downloads bar.

This is all to address the experience that I was having where sometimes when I download lots of files (usually program files), the downloads bar would get cluttered. 
