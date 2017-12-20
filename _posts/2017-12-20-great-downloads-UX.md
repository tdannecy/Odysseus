---
layout: post
title: Downloads UX — Odysseus Development Blog
posttitle: Great New Downloads Experience
header: 20th December 2017 — Adrian Cochrane
date: 2017-12-20 15:41:58 1300
categories: dev
---

It took me a little bit to get this working right, although much of that was me unwinding after all the refactorings I've been doing recently, but Odysseus now has a **great** downloads experience.

When you download a file it'll display the downloads bar whilst showing a combined progress bar in the dock. Should you attempt to close Odysseus while downloads are in progress, a "downloads window" will stay minimized so as to keep those downloads going. Then when a download completes you will be notified, it will by default open in the appropriate app, and if it's the last in progress download the downloads bar will close.

Additionally you can close the downloads bar on any window at any time, and when it reopens no completed downloads will clutter it up. It'll reopen either when a new download starts or when you explicitly tell it to via the app menu.

Implementation-wise while much of this was simply bugfixing, there were definitely new features added. Heck for bugfixing, I fixed a problem where Odysseus wasn't being smart enough when the server told it "[you figure out this filetype](https://kb.iu.edu/d/agtj)." However for the new features (dock-item progress, notifications, and the additional doorstop against accidentally cancelling downloads via closing Odysseus), those were implemented in a couple of new self-contained "traits". 
