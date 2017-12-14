---
layout: post
title: 12th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 6"
header: 12th December 2017 — Adrian Cochrane
date: 2017-12-12 10:16:59 1300
categories: cleanup1.0
---

Today I scheduled towards cleaning up all of Odysseus's "traits". To my surprise they were all simple enough that they hardly needed tidying up at all. Sure there's some FIXMEs in the error reporting trait, but I'm not sure how to fix them at the moment, they're not serious bugs, and the code remains clear regardless. The biggest thing I did there was to extract the singleton code for a WebKit.WebContext out into a  new "service" whilst keeping most the configuration in a trait. This was done to maintain an ideolized dependency graph between my Model, Services, Traits, & UI layers. 

To lay this ideal out:

* *Models* build upon nothing more than **WebKit** if that and are depended on by the *UI* layer.
* *Services* are depended upon by *traits* and are triggered either by the *UI* layer or through the initialization of *traits*. They may bring in their own 3rd party dependancies. 
* *Traits* depend on **WebKit**, *services*, and possibly the **WebTab** widget. Beyond some initialization code (which gets bundled up with the initializers of all other *traits* and some *services*), they are triggered exclusively by **WebKit** or the *services*. 
* The *UI* builds upon **GTK**+**Granite** to wrap **WebKit**. It shouldn't depend on any *traits* other than to initialize all *traits*, though it may build upon certain *services* and the *models*. 
* *Internal pages* are enabled by a particular *service*, and are provided to be integrated into the *UI* and/or *traits*. 

This ideal doesn't quite apply, and I don't plan for it too, but it's extremely close to the reality.

## Organizing traits

The biggest change I had to make was in adding some organization to the traits, for which I decided to group them by the extension mechanisms they use. This organization scheme, for example, may not suite bookmarks and history extensions, which would have components in both the autocompletion and navigation groups (in addition to their own internal webpage). But then maybe it's good to seperate out those components. 

The simplest of those groups was the concept of **autocompleters**. These extend the `AddressBar` via the `Completer` service rather than a `WebView`, and include the [DuckDuckGo](https://ddg.gg/) integrations as well as logic for implying an "https://" prefix on web addresses.

In the remaining there seemed to be two distinct groups. **Navigate** traits register to `WebView` signals related to page navigation and doesn't do much to the UI other than to navigate to a different webpage, if it even does that. **Decorate** traits on the other hand listen to a variety of other `WebView` signals and they often respond by customizing the WebTab. 

---

Wow, this blog post looks longer than my diff files today! I guess there was a bit to discuss about my thinking on these changes. 
