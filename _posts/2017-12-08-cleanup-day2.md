---
layout: post
title: 8th December 2017 — Odysseus Development Blog
posttitle: "Release Cleanup: Day 2"
header: 8th December 2017 — Adrian Cochrane
date: 2017-12-08 22:23:38 1300
categories: cleanup1.0
---

Today's cleanup was fairly involved, but on the lighter side I started by integrating the [recommendations site](https://alcinnz.github.io/Odysseus-recommendations/) into the first start. This was then followed up by numerous refactorings of the `BrowserWindow` class. 

Several of the cleanups there were simply about removing dead code, but I also moved a couple of concerns out into new modules/classes. More specifically I:

* Switched to using a singleton instance of the `Application` rather than a back reference from the `BrowserWindow`.
* Removed legacy persitance code, both from `BrowserWindow` and the `Application` implementation.
* Extracted persistance handling into it's own module.
* Removed some commented code which ensured a window always had a tab when shown<sup title="This was removed as it conflicted with dragging tabs out into their own window">1</sup>.
* Factorized out state tracking of window-visible `WebView`'s state. This requires the most explanation. 
* Text corrections to default welcome page, new-tab page, and NewWindow flag. 
* More minor cleanups which mostly flowed out of the above.

This has all made a huge difference in terms of code quality, but I'm still not quite happy with `BrowserWindow`'s code. I have trouble seeing how I can seperate out any more concerns very well as all it's remaining code connects controls up to the visible webview and vice versa.

What I can do to finish `BrowserWindow`'s cleanup is to build nicer APIs for it to build it's UI with. That is making it easier to add new `ToolItemWithMenu`s to the `HeaderBar` and new `[Image]MenuItem`s to their menus, and combine with keyboard shortcuts. If I did that maybe my code can be more declaritive, akin to the following::

```
go-previous-symbolic "Go to previously viewed page" web.go_back() <ctrl>-left
    sensitive = web.can_go_back
    foreach item in web.back_forward_list:
        item.title web.go_to_back_forward_list_item(item); icon = fetch from icon DB
go-next-symbolic "Go to page next viewed page" web.go_forward() <ctrl>-right
    sensitive = web.can_go_forward
    foreach item in web.back_forward_list:
        item.title web.go_to_back_forward_list_item(item); icon = fetch from icon DB
{Stack} visible_child = (int) web.is_loading
    view-refresh-symbolic "Load the page from the website again" web.reload() f5
        "_Ignore cache" web.reload_bypass_cache() <shift>-f5
    process-stop-symbolic "Stop loading this page" web.stop_loading() <esc>
{Odysseus.AddressBar/Entry} "Current web address"; text = web.uri,
    primary_icon = web.favicon, progress_fraction = web.progress
[FUTURE] starred|non-starred[web.uri in favs] "Save page to be revisited" *show bookmark popup* <ctrl>-b
    foreach link in DB.share_links:
        link.title web.load_uri(link.href.replace("%s", web.uri)); icon link.favicon
open-menu "Menu"
    "_New Window" new BrowserWindow().show_all() <ctrl>-n
    "_Open..." foreach uri in new FileDialog(...).run(): new_tab(uri) <ctrl>-o
    "_Save..." web.save_to_file(new FileDialog(...).run()) <ctrl>-s
    "_View Source" new_tab(yield Traits.view_source(web)) <ctrl>-u
    ---
    "Zoom In" web.zoom_level += 0.1 <ctrl>-+, <ctrl>-=
    "Zoom Out" web.zoom_level -= 0.1 <ctrl>--
    ---
    "_Find in page" tab.find_in_page() <ctrl>-f
    "_Print" new WebKit.PrintOperation(web).run_dialog(); <ctrl>-p

<ctrl>-t new_tab();
<ctrl>-0 web.zoom_level = 1.0
```

That psuedocode is much more concise and somewhat more featureful than the code I have already. 

### Tracking Visible `WebView`'s State
There's two main challenges with this code. The most obvious is in treating a mutable variable like a constant, but that isn't actually that hard. What is hard is to capture changes to the `WebView` which is probably due to the impedance mismatch WebKitGtk developers face between the C++ of WebKit and the C+GObject APIs of GTK & Vala. 

Particularly I face this in capturing when to disable the back or forward toolbar items. There are accessor methods for this, but no signals to capture. `load_change` does work great as long as you're just handling simple webpages, but it is not enough for the recent fad of "Single Page Apps" (including sites like GitHub and Valadoc). Capturing changes to the `uri` normally works for that (given I add a slight delay), but since that's not reliable I have a slow interval timer polling these methods. 

Given these complexities, it does help make for much nicer code to have a small class which a) hides it all behind dynamic properties & b) hooks WebTabs into the DynamicNotebook. 
