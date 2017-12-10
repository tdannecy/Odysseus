---
layout: post
title: 24th November 2017 — Odysseus Development Blog
posttitle: Tabs Now Pin
header: 24th November 2017 — Adrian Cochrane
date: 2017-10-24 19:07:25 +1300
categories: dev
---

I know it's been a while since the last post, but now I'm nearing the homestretch to when I'll feel comfortable publishing this to the elementary AppCenter. I'm really looking forward to it.

Before today I had a bizaar bug where the pinned-status of a tab refused to persist to the next use of the browser. Early on this was to be expected, as I used a overly simplistic persistance schema which did not track this information. But later I did save this data to the disk, and when I checked the data was correctly persisted. But when it came to restoring this data when the browser started, the tabs refused to stay pinned.

After some more investigation, and checking in with the Granite developers<sup title="I showed them a simpler program that exhibited the problems described here.">1</sup> I think I know what was wrong and have managed to fix it. The fix was to what until after the tab was added, using a combination of the tab_added and Idle events. The problem I think is that pinning a tab hides the label (duh?!)  but adding the tab to a notebook shows everything inside it. Gtk does afterall default to hiding incomplete widget hierarchies until you tell it to show or better show_all, and this would exhibit the issue I was having whilst being non-obvious in the code. 

### What Next?

Next I think I will try to make Odysseus start quicker by delaying page loading (which was a nice Midori feature), and clean up my code and get my branding straight. Then I plan to publish Odysseus to the AppCenter in a month as a Christmas present for all you elementary fans.
