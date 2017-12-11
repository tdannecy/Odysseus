---
layout: post
title: 11th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 5"
header: 11th December 2017 — Adrian Cochrane
date: 2017-12-11 14:11:05 1300
categories: cleanup1.0
---

Today I focused on the `Widgets/header` package, but as that's mostly code sourced from [other](https://github.com/elementary/files/blob/master/libwidgets/Chrome/ButtonWithMenu.vala) elementary [projects](https://github.com/elementary/wingpanel/blob/master/lib/Widgets/AutomaticScrollBox.vala) there wasn't much to clean up leaving me to focus on the `AddressBar`. `AddressBar` was already very nicely written, in part because of how simple it is, but I did manage to find some things to correct. 

At the lowest end there was a tiny bit of defunct code and expressions which could be written more concisely. At the other end it didn't quite take up all available space at certain window sizes and clicking an autocompletion didn't navigate to that link. 

The thing with sizing the addressbar is that left to it's own devices a text entry allocates itself a "natural size" that's much smaller than what I need. At the same time the headerbar doesn't know to expand it's title widgets to fit all available space, so those are left at their "natural size"<sup title="Or at least that's the behaviour I found while implementing the addressbar. Things might have changed now.">1</sup>. To fix this the natural size has to be much bigger so the headerbar knows to fill all available space with it. 

As for the fact you couldn't click an autocompletion to navigate to it's page, that was a surprisingly quick fix. I previously called two methods in the wrong order, causing an event handler to be added to the completions list before it existed. That's no longer an issue.

## What's next?
I have the overlays over the webpage next on my list to clean. Looking forward to what needs doing on that, there appears to be one or two little things but mostly I'd be wanting to make sure I can use a "shades" overlay to prevent clicking a webpage while it's got some sort of dialog open. 

---

1. Or at least that's the behaviour I found while implementing the addressbar. Things might have changed now.
