---
title: "Data vs Code"
date: 2013-01-15 07:15
comments: false
tags: code
language: english
---

When there's a problem with your software and it doesn't perform as expected on test data, *always* consider checking the data before you check your code. Many times data is easier to check. Here's a simple example to prove my case.

At work I was developing a piece of software that - amongst other things - had to display a text, stored in an SQL table, together with some formatting options. Each line of text had it's own entry in the database, along with those options. The function was quite transparent in that it SELECT'ed the text from the db and displayed it in a cycle. Still, somehow, the text was displayed without one final letter in the first line, while all other lines were kept intact. I spent about two hours walking the function step by step, checking every query and every variable change before turning to SQL to check the lines stored in the db. And in 10 minutes everything was fixed. As it turned out, the first line was stored with "bold" switched on. And (we are developing for 80x24 terminals) it inserted some invisible signs that took the line length over limit, causing the line to lose the last letter. As that bold doesn't really display that well in PuTTY, I hadn't noticed that.

So there's your lesson. Had I checked the db first, it'd saved me a couple of hours of time. 
