---
layout: post
title: Hypothetical Web Redesign — Odysseus Development Blog
posttitle: Hypothetical Web Redesign
header: 25th September 2017 — Adrian Cochrane
date: ## 2017-09-20 09:08:18 +1200
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

### 2.c) Presenting Information
As previously mentioned it's hard to imagine anything better than HTML, SVG, & CSS for this task. However the templating language can reduce some of the more recent complexity in CSS with media queries, imports, and variables. As for HTML it might prove interesting to use the XHTML syntax from the start, especially if that allows new elements to be defined. 

Notably there'd be no requirement for the browser to actually implement (X)HTML & CSS, as with some decent effort (and the help of XML) a conversion to SVG can be fully implemented in the templating language. And that script could be registered as the official conversion. This may leave some platform integrations and optimizations on the table, but it would help to get new browsers started quickly.

Whether or not a browser actually implements these languages itself, it would be useful to require browsers make sure they support it. 

