---
layout: post
title: Hypothetical Web Redesign — Odysseus Development Blog
posttitle: Hypothetical Web Redesign
header: 25th September 2017 — Adrian Cochrane
date: 2017-09-26 08:54:53 +1300
categories: misc
---

**NOTE** This long post is purely for very geeky entertainment. Feel free to skip it.

Inspired by [this excellent post](https://blog.plan99.net/its-time-to-kill-the-web-974a9fe80c89), I thought I would share my ideas about how I'd redesign The Web Platform if I got the chance I never will. In contrast to what's hinted at for part 2 of that artical, my design will be based on how to make The Web even better at what it already [excells at](http://idlewords.com/talks/web_design_first_100_years.htm). 

Simultaneously to improving the Web's strengths, this design will attempt to address it's majour weakness of being massively bloated. It's worth noting that this complexity doesn't express itself in the standards, except maybe if you want to compete on performance — particularly that of CSS, but rather the quantity of standards. 

So without further ado, let's look at improving the first strength.

## 1) Accessing Information
In all reality with modern Computer Science we could do [much better](https://ipfs.io/)<sup title="In large part this section is describing IPFS rather than inventing something new">1</sup> than The Web for distributing information. However The Web is the tool everyone has, relegating common usage of these new Computer Science tools to [complex](https://www.openstack.org/) [Hardware-as-a-Service "clouds"](http://catalyst.net.nz/catalyst-cloud). 

Specifically HTTP/The Web has the following weaknesses in regards to accessing information:

* It costs and is nontrivial to keep a website alive
* It's too easy to break links and loose cultural artifacts
* Requiring a connection to the "Internet Backbone" hurts reliability and performance
* It does not protect reader privacy
* It is vulnerable to censorship
* And more...

As such while I see no reason to redesign URIs, HTTP(S) and the DNS could do with an overhaul. 

### Requirements of the New Transport Protocol
In order to do away with the costs of hosting a website, improve reliability+performance, and to begin to address the other points the new system must not have servers, just "peers". Second it should be difficult for any information to dissappear, especially if someone has it bookmarked. Third no predictable computers should be told what pages are being visited.

To achieve these goals I will sacrifice the ability to dynamically generate pages on the server-side. 

From now on I will refer to this hyperthetical protocol as HyperText eXchange Protocol.

### 1.a) Fetching Static (never changing) Pages
All documents in HTXP will be addressable by a [hash](https://www.techopedia.com/definition/19744/hash-function) of it's content. 
1. These URIs will then be looked up in a [DHT](https://en.wikipedia.org/wiki/Distributed_hash_table) connecting the client to another peer which has downloaded the content. Ideally the DHT will be able to establish the connection by splicing together sockets rather than proxying the connection or handing out an IP address, though those would be reasonable solutions<sup title="Given who has what does not necessarily map to who's interested in what.">2</sup>. Also there'd be a hierarchy of DHTs for each network, so as to reduce the costs of accessing external networks. 
2. The servers will negotiate a trade of equal-sized "blocks". The usually the same number of blocks would be traded, but other strategies would exist for edge conditions. These alternative strategies would encourage the downloading of blocks the client would not otherwise be interested in. 
3. Links in the headers of these blocks would assemble multiple blocks together into a single "file", which would in turn be assembled via inline links into "documents".
4. The other header links will be prefetched to optimize the assembly of the document.

### 1.b) Websites
To resolve the path component of a HTXP URL, the header of an HTXP block/file can have named links with a rel of "file". These links could then be traversed explicitly via the URL, with no difference made between a "folder" and a "file".

### 1.c) Updatable Pages
If no content is ever allowed to be updated, than this web could quickly become useless and out of date. To fix this and allow mutable pages, several things would need to be done:

* Have another DHT mapping from identities to the constant URL of their homepage.
* Require that redirect to be [cryptographically signed](http://www.thefreedictionary.com/Cryptographic+signature) by the owner of the identity.
* Require each update to have a date and link to the previous version of the site. This helps to prevent any data loss and link breakage. 
* Establish the concept of an identity.

That last task is the relatively tricky one, especially if want memorable URIs. However an elegant solution could be to have a hardcoded website(s) where other websites are looked up. This way just by using what's already been described we get:

* Human readable domains
* Avoids breaking historical signatures
* Path traversal can easily be used to implement subdomains
* The ability to check a domain's registration hasn't been compromised. 
* Protection against surveillance and censorship.

### 1.d) Content Negotiation
To best implement global web accessible to all regardless of language and the filetypes supported by their computer, another step should be incorporated into HTXP URL resolution: content negotiation. This would involve a couple of new link types for HTXP block headers:

* The `language` link with the user's configured ISO language code(s) would be implicitly traversed.
* A `format` link labelled with a supported filetype would be implicitly traversed.
* The `filetype` link would point to an HTXP URI defining that format (see below).

### 1.e) Live Updates
With a minor addition to the underlying DHT technologies allowing temporary subscriptions to be recorded, readers can watch pages be updated in realtime. This in turn would remove a significant usecase of JavaScript. 

### Review
This is certainly more complex than [what exists in modern browsers](https://www.w3.org/Protocols/). However when we consider that it incorporates caching and much of "the cloud", it is simpler. Simpler in much the same way that [*systemd*](https://freedesktop.org/wiki/Software/systemd/) is simpler than SysV Init. 

Besides which it almost entirely does away with the need for [The Internet Archive's WayBack Machine](https://web.archive.org/), and [Service Workers](https://alistapart.com/article/yes-that-web-project-should-be-a-pwa). At the same time it provides the technology to underly self-hosting APIs later on, while providing much greater reliability, performance, privacy, and security.

## 2) Reading Information
This was split into a seperate point due to the length of addressing the last one. In stark contrast to fetching information, it is hard to imagine beating today's Web at this point. As such I'd leave HTML & CSS largely intact, whilst addressing the challenges and opportunities afforded by the new network protocol. 

Specifically I'd want to strengthen HTXP's format conversion, both so no one has to worry about file formats and to move data from web forms (described later) and elsewhere into webpages. 

### 2.a) Implementing Parsers
As files downloaded off HTXP and other protocols are almost inherently sequential, they need to be parsed before they can be made sense of. In order to offload the need to understand how to parse all relevant formats, a [BNF](http://www.garshol.priv.no/download/text/bnf.html)-based language would be defined with the addition of labels for the [AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree) nodes. These "nBNF" scripts would be defined at the URIs used to designate the filetype.

### 2.b) Implementing Renderers
Once we have an AST, it needs to be rendered into a known format. This would hook into the content negotiation using links off the file itself and/or it's filetype, as well as a language which converts from the nBNF's AST to some text. A templating language seems most appropriate (that is everything's code unless marked otherwise), and basing it's syntax off the [functional paradigm](https://maryrosecook.com/blog/post/a-practical-introduction-to-functional-programming) could both keep this language very simple and [turing complete](https://stackoverflow.com/questions/7284/what-is-turing-complete#7320) whilst affording several optimizations. 

To help prevent cross-site scripting type attacks, text fragments templates output should by default be parsed specially by nBNF. 

### 2.c) Presenting Information
As previously mentioned it's hard to imagine anything better than HTML, SVG, & CSS for this task. However the templating language can reduce some of the more recent complexity in CSS with media queries, imports, and variables. Also we now have the opportunity for XML variants (including HTML) to declare a stylesheet under their namespace URI with no real performance hit. As for HTML it might prove interesting to use the XHTML syntax from the start, especially if that allows new elements to be defined. 

Notably there'd be no requirement for the browser to actually implement (X)HTML & CSS, as with some decent effort (and the help of XML) a conversion to SVG can be fully implemented in the templating language. And that script could be registered as the official conversion. This may leave some platform integrations and optimizations on the table, but it would help to get new browsers started quickly.

Whether or not a browser actually implements these languages itself, it would be useful to require browsers make sure they support it. 

## 3) Publishing Information
This is an interesting one. Today's Web is almost too good at publishing information, as it happens without the user being necessarily aware that it's happening. So the trick in this redesign is to ensure the user is always aware of where their information is being sent. 

A good way to achieve this would be to throttle all information to be sent to webservices (or elsewhere) through the trusted UI of Web Forms. This wouldn't seriously harm most workflows seen in today's "WebApps" whilst significantly increasing the trust it's reasonable to place in the Web. Also since forms are now trusted UIs, it should be impossible to restyle them<sup title="Which is a good and often ignored usability practice anyways">3</sup> and they should now render with a frame and label describing where the data will be sent. 

### 3.a) Receiving Information
With the rest of this rebuilt Web Platform it would be trivial to tell a form to publish it's information and to render that data nicely. Add another DHT that can be used to lookup pages published using a given form and a large fraction of today's forms (including comments, wikis, forums, issue trackers, etc) could be made truly serverless. Allow the form inputs to feed data back into the templates which rendered the pages they're in and many of today's [SaaSS](https://www.gnu.org/philosophy/who-does-that-server-really-serve.html) webservices would both be trivial to code and no longer be SaaSS. This covers the vast majourity of forms on the web today. 

However there'd probably still be circumstances when we'd still need to process the data on a central server<sup title="Afterall there's only so far one can go with a peer-to-peer database.">4</sup>. In those cases we'd need to bring back HTTP (or rather HTTPS). Hopefully this time we could avoid the problems of user agents and fingerprinting. And hopefully if we can stick to that functional templating language for serverside scripting, we can avoid some of the complexity of the cloud. However this post is long enough without considering how the servers would be implemented. 

### 3.b) Authentication & Payments
These are core components of the modern web experience that were unfortunately left quite tacked-on. That would be remedied in this hypothetical rebuild by defining them as form elements.

Accounts would be authenticated with a cryptographic signature on a per-form basis, with an identity coming from the same domain-name system I've described for websites to use. 

Payments meanwhile would be built on content negotiation through currency exchanges, to convert from the currency the user has to the currency the website accepts. This would work in a similar way to what I described for fetching webpages. 

### 3.c) Writing Webpages
Web developers often forget that normal people don't like to write textual code, and would rather have a nice WYSIWYG. While noone has stepped up to offer this for today's web, in this hypothetical it'd be trivial to implement such a tool since:

* All the web languages are declarative
* nBNF makes it easy to edit code programmatically
* Publishing would now be built into browsers

The only thing that's missing would be intuitive interactions, which brings us to...

## 4) A Touch of "Appiness"
It's certainly not a strength, but the Web benefits from allowing developers to introduce some custom behaviour. This is particularly true when it comes to visualizations (a.k.a. charts) and maps. 

While theoretically the templating language can support these inputs using [FRP](https://gist.github.com/staltz/868e7e9bc2a7b8c1f754), that is stretching it a bit far and a new language would be better suited. 

### Requirements for a "Controller" Language
This language would receive input events on certain inputs and manipulate a model to be rendered by the template. To excel at this, the language would need to be able to manipulate:

* Events, with use of CSS selectors
* Numbers
* Vectors
* Strings
* Lists

For the sake of it, let's make this language easily verifiable with some syntax extensions. 

### Design of the Controller Language
All the important constructs this language needs to manipulate can be nicely combined into a unified datatype by taking inspiration from [Numpy](http://www.numpy.org/) and Python comprehension syntax. Furthermore to support objects (to use for organizing data) we can simply unify the outer arrays with a dictionary type, at which point since we have dictionaries we might as well support treating them as sets. Add structured control flow and it's trivial to implement just about any event handler.

Speaking of events, the language would need a control flow syntax for subscribing to an event whilst giving arguments to filter when the callback is actually called. For the built-in events this would mostly be CSS selectors specifying which elements of the rendered HTML the event should apply to. 

### Browser APIs
Safe in the knowledge that the transmission of information is restricted, the browser would offer APIs to access the time, location, and random numbers. Additionally cookies would be entirely replaced with localstorage. Beyond that new APIs should be designed in a way readily and automatically polyfilled, so browsers don't need to implement them. Predominantly this would mean a preference for new filetypes over new functions. 

### Packaged Components
While templates could be used to essentially `#include`  modules when dealing with any single language in this suite, it would be convenient to package all the UI components together into a single component to be included in a webpage. To achieve this, I would allow extending the HTML language using XML namespaces.

Notably all the form components and hyperlinks could be self-hosted on this hypothetical web using this concept of components. 

## Summary
If I miraculously got the chance to reengineer The Web, I'd keep HTML, SVG, and CSS largely intact whilst replacing JavaScript with three simpler and domain-specific languages. These would include a parser, templating, and a matrix-based controller. Those new languages combined with a peer-to-peer distribution protocol would teach browsers how to render new formats, as well as improve the reliability, security, and privacy offered by the web. 

In actual reality what is achievable if we want to improve the Web is to:

1. Work on the [peer-to-peer distribution](https://github.com/ipfs/js-ipfs/) so it works in unmodified browsers.
2. And encourage the adoption of *real* app platforms like GTK+/Granite.

I suspect that the author of the post who inspired me to write this one will propose a universal app platform, but I do not believe that's appropriate in most cases. Different platforms have different conventions and such a universal platform will likely run into the fallacy of "write-once run anywhere" (really it's "write-once optimize everywhere"). 

But that was fun! Wasn't it?

---

1. In large part this section is describing IPFS rather than inventing something new
2. Given who has what does not necessarily map to who's interested in what.
3. Which is a good and often ignored usability practice anyways
4. Afterall there's only so far one can go with a peer-to-peer database.
