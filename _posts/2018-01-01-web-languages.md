---
layout: post
title: Web Languages — Odysseus Development Blog
posttitle: Language Roundown for Internal Pages
header: 1st January 2018 — Adrian Cochrane
date: --2017-12-31 16:00:42 1300
categories: dev
---

**Happy New Years!** You may think me odd, but I started my year adding the infrastructure I needed for Odysseus's resolutions. 

That is I integrated SQLite into my Prosody templating language, which in turn helps Odysseus to render data it has collected (manually or automatically) on pages you've visited. The following step would be to use this to implement history, at which point I'll release these changes. 

Having done this, I have successfully pulled together the full suite of languages I'll want to use in Odysseus, so let's celebrate by having a rundown! That is I'll run through the strengths of each of these languages, and briefly how they work in Odysseus.

## Languages
### [SQL](https://sqlite.org/lang.html) (implemented in [SQLite](https://sqlite.org/))

**Strengths:** Processing and extracting collections of data.

**Data Model:** "rows"/"tuples" of data grouped by their common and predefined structure, all of which gets persisted to the harddisk by default.

**Paradigm:** Specify a condition/ordering/grouping/etc that output data must match. 

**Turing Completeness:** Not practically. 

**Parsing:** Using [Lemon](http://www.hwaci.com/sw/lemon/) DSL. 

**How is it run:** Compiled down to a bytecode "VDBE" via [hueristics](https://sqlite.org/optoverview.html) and a [simple AI](https://sqlite.org/queryplanner-ng.html). 

#### [VDBE](https://sqlite.org/opcode.html) (implemented in [SQLite](https://sqlite.org/))

**Strengths:** Traversing saved collections of data.

**Data Model:** On-disk [BTrees](https://en.wikipedia.org/wiki/B-tree), with a BTree listing them all. A BTree in turn efficiently combines the functionality of an sorted-[list](https://en.wikipedia.org/wiki/List_(abstract_data_type)), a [Map](https://en.wikipedia.org/wiki/Associative_array), [Set](https://en.wikipedia.org/wiki/Set_(abstract_data_type)), and more. These are stored in a [single file](https://sqlite.org/fileformat2.html), which gets [locked](https://sqlite.org/atomiccommit.html) for every transaction. Dynamically typed output rows may be stored in virtual registers. 

**Output:** Yields tuples from those BTrees.

**Paradigm:** Procedural, unstructured control flow.

**Turing Completeness:** Yes.

**How is it run:** Interpreted directly via a giant switch statement. Reasonable performance.

### Prosody Templating

**Strengths:** Moving data from one place to another, textual place. 

**Data Model:** Coerces between maps, iterables, text, and integral or floating-point numbers. 

**Output:** Plain, auto-escaped, text.

**Turing Completeness:** Yes, once I enable the `{ % block %}` tag. 

**Parsing:** Two levels of manually written lexers, and a reentrant parser dispatching the logic to registered [tags](https://github.com/alcinnz/Odysseus/wiki/Templating-Reference).

**How is it run:** Dynamic dispatch on the AST. Theoretically slow, but makes up for it by avoiding allocating & copying memory. 

### HTML (implemented in WebKit WebCore)

**Strengths:** Adding structure both to text and other linked-in resources. 

**Data Model:** A [tree](https://en.wikipedia.org/wiki/Tree_(data_structure)) with text as leaves, elements as branches, and attributes annotating the elements. 

**Paradigm:** Data format.

**Turing complete:** With CSS, not really. 

**Parsing:** TODO document. Involves dynamically dispatching AST construction to classes for the different elements.

**How is it run:** Initially interpreted via dynamic dispatch during parsing to register event handlers, request any necessary resources, and possibly construct a "shadow DOM". Slow, but on a slow path. 

Later it's combined with CSS to construct a "Style Tree".

### CSS (implemented in WebKit WebCore)

**Strengths:** Describing the appearance of HTML.

**Data Model:** That of HTML.

**Paradigm:** I fail to classify it, but consists of what CSS calls "selection" and "cascade".

**Parsing:** TODO: document.

**How are selectors run:**

1. Which elements have been changed and require restyling is checked. 
2. Previous HTML siblings are checked to see if their results can be reused. 
3. The tagname, ID, class, or psuedoclass is looked-up in a hashmap to constrain selectors that need to be checked.
4. A bloom-filter is used to probabilistically (with no false negatives) discard selectors. 
5. The remaining selectors are quickly compiled to machine code for high-throughput tests. 

**How is cascade run:** The properties prescribed by rules outputted by the selector interpretor are first consolidated into something between an array and C structure; before that's compiled down into a Style Tree whilst applying CSS inheritance and animations. The latter step is performed by a JSON file compiled down into C++ via Perl. 

#### The Style Tree

**Strengths:** Stores style data efficiently in the context of CSS inheritence.

**Data Model:** Organizes CSS into chunks of related properties with commonality in how they handle inheritence. This both reduces memory usage as these chunks can usually be shared with the parent style, but it also maintains good data locality to improve CPU performance. 

**Paradigm:** Data model.

**How is it run:** A simple pass generates the right type of Render Tree node, which'll then refer to the style tree for details.

#### The Render Tree

**Strengths:** Layout, basic rendering.

**Data Model:** A tree of differently typed branches, each with it's own logic. 

**Paradigm:** Data model.

**How is it run:** Multiple passes using dynamic dispatch informed for performance by an initial pass detecting what has changed. These passes include normalizing the tree's structure, laying things out, and compiling a Tile Tree. The former passes essentially work by overlaying another tree ontop of the render tree which specifies how text is split into "runs" and how elements get positioned onscreen. 

#### The Tile Tree

**Strengths:** Rendering transparancy and movement. This significantly simplifies the analysis of what needs rerendering in the Render Tree.

**Data Model:** A tree of positioned images. 

**Paradigm:** Data model.

**How is it run:** Takes the images outputted from the Render Tree and blits them together in the GPU (or, I suppose in some cases, the CPU) either by itself (when using X11) or in the window manager (on Wayland or Mac OS X). 

### JavaScript

**Strengths:** It was quick for Brendan Eich to hack together. It is a "general purpose language" that doesn't have the same sort of strengths SQL, Prosody, HTML, and CSS do as DSLs. 

**Data Model:** "Objects" (maps) with prototypal inheritance, numbers, text, booleans, & arrays. Internally "structures" are used to consolidate prototypes and property names between multiple similarly structured objects, as that significantly reduces relatively slow (but still fast) operations in the datamodel. 

**Paradigm:** Procedural with structured control flow and significant use of callbacks. 

**Parsing:** TODO: Document.

**Turing complete:** Definitely!

**How is it run:** Has multiple levels interpretors where later stages are used for more frequently called code, all the latter of which compiles into machine code:

1. *LLInt* Quick start through interpretation of a high-level bytecode. 
2. *Baseline* Removes the overhead of interpreting the LLInt bytecode.
3. *DFG* Removes overheads of the same type system and common-cases of method calls. 
4. *FTL* Thorough optimization of machine code via *B3* and *Air* intermediate languages. 

Each of these have their own bytecode. 

### Machine Code (implemented by Intel, AMD, or others)

**Strengths:** Relatively easy to interpret using an electrical circuit. 

**Data Model:** Binary numbers (integer or floating point, signed or unsigned) stored in either in a finite number of high-speed registers or at a memory address given by another number. The data at memory addresses is stored in a seperate circuit prioritizing storage capacity that is very slow relative to the CPU. 

**Paradigm:** Procedural with unstructured control flow.

**Turing complete:** Definitely!

**Parsing:** Little to no need. However there is need to hide the relative sloooowness of RAM. 

**How is it run:** Traditionally used the electrical equivalent of a switch statement for interpretation.

Now it figures out which instructions it needs to interpret it immediately, and routes it to a circuit that can do the appropriate computation. Also significant amounts of predictions are now involved in interpreting the unstructure flow in order to keep the instructions flowing. 

### Vala, C, C++, Python, Shell
Not worth describing here. 

## Summary

Sure, it's true that I'm now using a large number of languages to implement the internal pages for Odysseus. But each of these languages addresses their problemspace very well, with specifically targetted syntax and internal optimizations. 

What this all means is that rather than the code for those pages prescribing the steps to take to display that data, I'll be able to simply say what data I want displayed, how it is structured, and how it should be displayed. tfggcfffffff8[,,,,,p6o=-
1A[]2
