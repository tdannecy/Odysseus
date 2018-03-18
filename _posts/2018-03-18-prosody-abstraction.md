---
layout: post
title: Abstraction in Prosody Templating — Odysseus Development Blog
posttitle: Abstraction in Prosody Templating
header: 18th March 2018 — Adrian Cochrane
date: 2018-03-18 23:09:12 1300
categories: dev
---

Now I'm seriously beginning to work with the Prosody templating language (it's basically just Django's) I defined early on in Odysseus development, and now I'm seriously starting to use it. To discover it's strengths and weaknesses, and how I can make it best suited to my work.

And as such I've been improving Prosody. I spotted opportunities for some simple refactoring, added some new behaviours, and some new tags. One of these new tags is called `{%% random %%}` and is used to randomly choose a useful tip to render to the bottom of the [newtab page](odysseus:home). But beyond that to truly understand the improvements I made you need to go deep into how Prosody works. 

## Querying the database

Database queries are something I had working in Odysseus since version 1.1.0 (though I blogged about my efforts there much earlier), but they are a vital component of the [odysseus:history](odysseus:history) page I've been working on and are important to understand for later in this artical.

These queries can be performed in Prosody by surrounding them with `{%% query %%}` and `{%% endquery %%}` template tags, where `{%% each-row %%}` and `{%% empty %%}` tags can precede the `{%% endquery %%}` tag to describe how to format the results into HTML. However that initial section where you write your SQL doesn't accept any template tags, only variables, for reasons I'll get to shortly. `{%% query %%}` handles reporting errors itself.

Behind the scenes once the `{%% query %%}` tag is parsed, it compiles that initial section done into a precompiled SQLite statement. Then whenever the template is rendered the Prosody variables are loaded into the prepared statement, and the results from running said statement are iterated over and passed back into Prosody (via an adaptor to Prosody's datamodel) for rendering to HTML.

This technique of using precompiled SQLite statements both improves performance (because the work SQLite does optimizing queries no longer needs to be done each time the page is rerendered) and resiliant (as this helps SQLite keep the SQL syntax clear from the data we're embedding into it). Furthermore if it was being used on real website doing this would be vital for security, as attackers could purposefully confuse SQLite this way in order to access data they shouldn't. But great care is taken that noone other than you can see the pages Prosody renders, so that isn't a concern.

### Database schema versioning
The database consulted by `{%% query %%}` is initialized on application start with a sequence of SQL statements provided by a special template. This template is provided a schema version number stored in the header of the database file (yes, an SQLite database is one file) and once it's done it stores a new version number in that header. Said template then uses comparison checks (and not much else) to avoid reexecuting previous statements.

## Paginating browser history

It turns out pagination is vital for ensuring WebKit doesn't freeze as it reads in your entire browser history, and making that pagination work nicely required some extensions to Prosody. Specifically it required not only the ability to query the database for the page count, but it also required iterating that number of times and checking the equality of page numbers.

### Iterating over a range

Prosody already had a tag for iterating over the values contained in some variable, so I ended up deciding that iterating over a number should give you all numbers from 0 up-to but not including itself. After deciding on those semantics, it was a simple matter of definining a new coercion in my data model (and do so again for data originating from SQLite). 

### Comparison checks

The support Prosody has for comparison checks (being based on widely used templating syntax) may be a slightly overkill for what I actively use. But it is actively used both for initializing the database and for paging [odysseus:history](odysseus:history), and hasn't added any maintainance burden in my experience.

It uses TopDown Operator Precedance parsing, which centers around a `expr` method that parses infix/prefix/suffix operators with a precedance greater than the given one. This method in turn calls `nud` and `led` methods on prefix and infix/suffix operators respectively, which may then recurse back into the `expr` method. This allows for arbitrarily complex expressions without suffering any performance penelty, it's always roughly one method call per operator.

TDOP does meanwhile require a pass to translate tokens (given by the smartsplitting used everywhere else in Prosody), but certain identifiers gets translated into special operators and everything else is parsed as a variable. And after parsing, the operators know form a tree which can be interpreted simply by calling a (pair of, for the sake of typechecking) recursive and dynamically dispatched methods.

---

These expressions are then integrated into the Prosody syntax via the `{%% if %%}` tag (which may be followed by `{%% elif %%}` tags and an `{%% else %%}` before it's closing `{%% endif %%}`). There's not much special about this tag beyond this fact.

In [odysseus:history](odysseus:history) this is used to determine whether to render a link to a given page number or to highlight it as the current one.

## Abstraction

Once I integrated search (as described in yesterday's blogpost), I found there was an issue in that Prosody required me to duplicate SQL fragments and thus risk letting them get out of date. Which in very practical terms meant that paging and search didn't work together well at all. So I had to add a new tag to address this.

And by doing so, I was given the opportunity to tidyup some other ugly code around highlighting the date changes.

### Abstracting around `{%% ifchanged %%}`

`{%% ifchanged %%}` is a template tag that tracks the values it's seen in the previous loop iteration and checks if it's changed. In [odysseus:history](odysseus:history) it's used to highlight changes in particular date segments. However that led to code which repeatedly formated the same date just to decided whether to wrap it with `<strong>` HTML tags.

To address this I built a `{%% macro %%}` tag by which templates can define their own template tag, and have the body of the `{%% macro %%}` be inlined there with specified variables (re)defined. The inlining was vital because if I had each invocation share the same template AST, then the `{%% ifchanged %%}` tag would see the values from the last call to that macro and not the last iteration through the loop. (This works differently from Django due to Vala's more rigid type system, in that the previous values are stored in the AST node itself rather than the data context. This leads to some quirkiness around the first iteration, but that's easier to design around then fix.)

The new macros are added to a template tag library local rather than the global one to the template being parsed, after checking that it won't accidentally redefine a tag. And it makes sure the local tag library is available within the macro, though recursion would cause Odysseus to crash (I might want to error check that better).

To define variables for the macros, I wrapped the inlined template with a newly generated `{%% with %%}` tag. `{%% with %%}` in turn runs that subtemplate with a new data context which lazily computes variable values when it's first fetched. That wasn't consciously a performance improvement, it's just what I found easiest to implement.

### Abstracting over `{%% query %%}`

Abstracting over `{%% ifchanged %%}` was very nice, but it was vital that I abstracted over `{%% query %%}`, which involved teaching `{%% query %%}` how to handle `{%% with %%}` tags (which are also generated by both macros and translations).

It wasn't hard to extend the code compiling Prosody into SQL with a corresponding array of Prosody-variable arguments to make this work, as I found I could easily capture the variables from within the `{%% with %%}`'s body. But it was tricky to inline the context variables into those captured ones from inside the macro.

You see, a variable in Prosody consists of a variable path OR a literal value followed by a pipeline of "filters", some of which are given a single<sup title="This was easier to implement, I'm not finding it constraining, and I like the syntax.">1</sup> additional argument. So while often the variable wouldn't need rewriting or could simply be replaced with one from the context being inlined, there can be a tricky situation where additional path traversal needs to be inserted between the pipeline for the variable being inlined and the one it's being inlined into. For that I implemented an internal filter that performs path traveral in the middle of the pipeline.

And then ofcourse any arguments to the filters in this pipeline also needs to be inlined.

## The Result

These enhancements to Prosody really helped make for a nicer browser history viewer, as well as made that page more maintainable and to some extent have even made Prosody more maintainable. And for that I'm quite grateful for the work I did on it.

---

1. This was easier to implement, I'm not finding it constraining, and I like the syntax.
