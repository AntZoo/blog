---
title: "Java and CLASSPATH"
date: 2012-09-01 20:58
comments: false
tags: java 
language: english
---

With this post I am beginning a series of posts on programming. These'll be pretty basic things, at least for now. But every time I learn something new I will create a new post and update you on my progress. Who knows, maybe someone will even find these posts useful! :) If not, it doesn't matter, as I will be also posting these for my own future reference. 

Now, at the moment I am struggling through the book Thinking in Java by Bruce Eckel. Not that it isn't interesting, no. It is great. But I'm so tired lately that I am constantly very sleepy and as soon as I begin reading I start falling asleep. 

But yeah, let's cut to the chase. I won't write anything about the first chapters, I am long past them. Today I found out about:

1 Classpath;  
2 Packages;  
3 Varargs.  

### CLASSPATH
I tried to find out how to use it for quite some time without any luck. None of the web pages I saw could really explain it to me. But mr. Eckel's book is magical, it made everything sound very simple, as it always does. The CLASSPATH environment variable tells the java compiler where to look for .class files and for .jar files. And that's all there is to it. .Class files are compiled .java files and .jar files are compressed libraries. How the compiler looks for them will be further explained it the next section, which is...

### Packages
That one really surprised me. I never thought that the hierarchy of the packages had any other meaning than an organisational one. Turns out when the compiler gets a path from the CLASSPATH variable, it begins looking for the classes is seeks by converting the package names into paths. It substitutes dots with slashes and, for example, when it sees a package named "com.thezujev.packagename" and gets the "c:\javalib" path from the CLASSPATH it looks for the package in "c:\javalib\com\thezujev\packagename". 

### Varargs
That's one of the ways to declare method arguments. You specify barrages in the following form: public methodName (String... args). That ellipsis means that the count of parameters passed to the method can vary and be anything from 0 to infinity (well, probably no infinity, but I am not aware of the top limit). This can come in handy later on. What gets passed inside is an array, members of which can be accessed, as always, with the args[] notation, first member being 0.

### Conclusion
So, that's it for today. Hope it was fun, next topics won't contain anything else except the new stuff, but today I had write some intro.
