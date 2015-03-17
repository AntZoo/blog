---
title: "HIL-LA-RI-OUS"
date: 2011-05-16 02:27
author: Anton Zujev
comments: falsee
external: "http://fuckyeahcomputerscience.tumblr.com/post/1058204927/ladies-look-at-your-code-back-to-mine"
tags: blog link
language: english
---

Ladies. Look at your code.

    return Iterables.filter(
        employees,
        new Predicate() {
        	public boolean apply(Employee e) {
            return e.isPartTime();
		}
	});

Now look at mine.

	return Iterables.filter(employees, {Employee e -> e.isPartTime()});

Now back at your code.

	return Iterables.filter(
		employees,
		new Predicate() {
			public boolean apply(Employee e) {
			return e.isPartTime();
		}
	});

Now back to mine.

	return Iterables.filter(employees, {Employee e -> e.isPartTime()});

Sadly, it isn’t mine.

But when it stops using inner-class-scented Java and switches to JDK 7, it could smell like mine.

Look down. Back up. Where are you? You’re in an IDE, with the code your code could smell like. What’s in your hand? Back at me. I have it. It’s a lambda expression, with two arguments of that type you love.

Look again: the lambda is now a method reference!

	return Iterables.filter(employees, Employee#isPartTime);

Anything is possible when your code smells like fresh new JDK 7 hotness and not inner classes. I’m on a horse.

*I just can’t stop laughing.*
