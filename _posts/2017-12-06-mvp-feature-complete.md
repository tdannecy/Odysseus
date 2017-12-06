---
layout: post
title: 6th December 2017 — Odysseus Development Blog
posttitle: MVP - Is Feature Complete
header: 4th December 2017 — Adrian Cochrane
date: -- 2017-12-04 16:24:43 1300
categories: dev
---

Today I got dragging a tab [out into it's own window](http://www.google.com/googlebooks/chrome/small_18.html) working, which is part of the [behaviour](https://github.com/elementary/granite/blob/master/lib/Widgets/DynamicNotebook.vala) of a [standard elementary tabbar](https://valadoc.org/granite/Granite.Widgets.DynamicNotebook.html). This required [messing with the task scheduling](https://valadoc.org/glib-2.0/GLib.Idle.add.html) a little for it to work<sup title="I don't fully understand why">1</sup>, but the [Scratch](https://github.com/elementary/scratch/blob/master/src/Widgets/DocumentView.vala#L246) text editor served very well as [sample code](https://elementary.io/open-source) to get any issues resolved. What I didn't manage to get working is [restoring tab history](https://alcinnz.github.io/Odysseus-support/guides/why-do-tabs-lose-history.html), but that'll have to wait until a particular [WebKitGTK update](https://bugs.webkit.org/show_bug.cgi?id=26517) which I won't let hold up Odysseus's release any longer. 

Over the next two weeks (bit over) I'll be going through each file of this project and tidy them up, and figuring out how best to promote Odysseus in the elementary AppCenter. These code tidies won't just involve making the code clearer, but also fixing anything that isn't working the best, and moving away from [deprecated APIs](https://valadoc.org/granite/Granite.Widgets.AppMenu.html). 

---

1. I don't fully understand why.
