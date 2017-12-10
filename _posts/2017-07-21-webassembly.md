---
layout: post
title: WebASM — Odysseus Development Blog
posttitle: WebAssembly
header: 21st July 2017 — Adrian Cochrane
date: 2017-07-21 11:46:38 1200
categories: standards
slug: WebAssembly
---

Another recent standard that deserves consideration is [WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly), as it provides web developers a closer-to-the-metal language with which they can better obfuscate their code. 

This could be of great concern to me as "View Source" can become a lot less useful, and like [obfuscated JavaScript](https://javascript-minifier.com/) it can be used to [sneak proprietary software onto user's computers](https://www.gnu.org/philosophy/javascript-trap.html). However as WebAssembly can only communicate with the user via JavaScript and can only really be used for [CPU-bound tasks](https://en.wikipedia.org/wiki/CPU-bound), I think it's ability to restrict the end-user is quite limited.

Sure it can be combined with [canvas](http://html5doctor.com/element-index/#canvas) to obfuscate away website data as a form of DRM, but you could do that already. Heck this is not dissimilar to the concept of a [Single-Page WebApp](https://en.wikipedia.org/wiki/Single-page_application). 

At the sametime I don't think it'll be all that useful, as the applications I've seen mentioned for them are [better suited to native applications](https://ar.al/notes/the-documents-to-applications-continuum/). Web pages are near-universally [I/O bound](https://en.wikipedia.org/wiki/I/O_bound). Or if websites want to use it for decoding videos, why don't they just distribute it in a format the browser natively understands? This is [not a chore](https://gstreamer.freedesktop.org/documentation/plugins.html) for Odysseus, GNOME Web, and other WebKitGTK based-browsers. As such I predict that WebAssembly will not take off. 

As for whether this is a burden for browsers to implement, my understanding is that it's not. WebAssembly is a trivial language to parse and interpret, and if your JavaScript engine implements basic optimizations WebAssembly will almost immediately be fully optimized. Furthermore WebKit essentially already had it implemented as a closer-to-the-metal yet cross-platform language to implement their JavaScript interpretor in. 

In summary, I don't think WebAssembly is a major threat to end-users or complication to browser engines. As such I won't be blocking it. But I do think it's a worthless standard that will not get any serious use. 
