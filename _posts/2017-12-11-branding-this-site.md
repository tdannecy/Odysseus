---
layout: post
title: 11th December 2017 — Odysseus Development Blog
posttitle: Site Upgrades, Now With Branding & Comments
header: 11th December 2017 — Adrian Cochrane
date: 2017-12-11 09:03:44 1300
categories: cleanup1.0
---

If you've been reading this blog (which I don't imagine many have been yet), you may have noticed it looks much more professional now. This came about over last night with most of the changes revolving around incorporating a splash of branding. Though I also made the header's gradient more pronounced and adjusted the layout of whitespace so the site both looks nicer and so it no longer triggers an ugly scrollbar at the bottom. It actually quite surprised my how big of a difference a little branding makes. 

I especially like the effect of applying my brand colours to the [links](https://350.org/), as that nicely spilled my brand out of the header onto the rest of the page. And it did so whilst emphasizing the most characteristic component of the Web<sup title="The component which actually makes it a mathematical 'web'/network/graph.">1</sup>. However I did need to embolden those links to compensate for the unreadability of those colours. 

I made all these changes whilst maintaining the same [visual metaphor](http://www.headfirstlabs.com/books/hfwd/): Odysseus's website is meant to look like the browser it's promoting. That is, if you couldn't tell, it's header roughly resembles a `HeaderBar` (which is what *[elementary](https://elementary.io/)* and *[GNOME](https://www.gnome.org/)* calls their combined toolbar & titlebar), the navigation bar resembles the tabbar complete with pinned tabs, and beneath that is a highly readable webpage.

### Commenting

While [GitHub](https://github.com/) does provide a very nice service for publishing my code and related materials like these sites, they do constrain how I can solicit communication from you my audience. For the longest while I thought that meant you had to "fork" the site in order to append your comments to the bottom, which needless to say is quite a bit of friction for an effective comment system. But now I had the [wiki facilities](https://help.github.com/articles/about-github-wikis/) pointed out to me as an effective base to build comments on<sup title="This does mean I need to ask commentors nicely not to edit other's comments, but that's why I'm calling these 'talk pages' akin to Wikipedia's.">2</sup>.

Thanks to a number of aspects of GitHub's software, it turned out to be surprisingly easy to hack a reasonably nice comment system together:

* If you visit a GitHub wiki page that doesn't exist, GitHub will present a form for you to create that page.
* GitHub has a strong habit of building highly readable URLs. 
* GitHub runs all it's sites through [Jekyll](https://jekyllrb.com/) before deploying them to resolve templates, which also
* Populates a slug field on all blog posts derived from it's filename. 

---

1. The component which actually makes it a mathematical 'web'/network/graph.
2. This does mean I need to ask commentors nicely not to edit other's comments, but that's why I'm calling these 'talk pages' akin to [Wikipedia](https://en.wikipedia.org/wiki/Talk:Main_Page)'s.
