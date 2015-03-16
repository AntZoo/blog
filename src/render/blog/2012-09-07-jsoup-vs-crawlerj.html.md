---
title: "JSoup vs Crawler4j"
date: 2012-09-07 00:53
comments: false
tags: java 
language: english
---

I have been writing a project in the last week that will be my first functioning Java project (at last!). It's called The YouTube PLD, as in "The YouYube Playlist Downloader". The main idea was that I'd create a playlist in YouTube where I'd put different music videos and then I'd run this app, put in the playlist ID and it would parse out the links of all the videos in the playlist and then download their audio tracks. Sounds simple enough, right? Well, there were a couple of challenges - I didn't know anything about either parsing a webpage or constructing GET requests, neither about downloading files with Java. So, I had to learn it all.

This post is about the parsing part. Initially I knew about a library called crawler4j and I intended to use it. The result wasn't completely satisfactory because when I ran the app in debug mode, I saw that the crawler was exactly what it was created to be - a, well... crawler. It didn't just get the page and parse it to give me the stuff that I wanted. When it extracted the links I needed, it continued to do something rendering the app unusable for another 5-10 seconds. It was anything, but a nice experience. So, I went and googled for an alternative.

The alternative is JSoup - an extremely great parser. It is fast, it is mindbogglingly easy to use (and still, I think I could write a better code than what I have written) and it is pretty versatile. The only thing you have to do extract the links in a certain page is:

<code>Document doc = Jsoup.connect(url).timeout(10000).get();
Elements links = doc.select("a[href]");</code>


Boom! They're in the "links" object. The timeout (in ms) is there because otherwise YouTube always timed out. I then ran the links through a regex to filter out only those relevant to my use case and to only extract the video id's and afterwards I was ready to code the next step of the application.

The YouTube PLD v.1 will be incomplete in terms of features and probably quite buggy/laggy, but I will continue to develop it and make it better. It is at the moment dependent on the youtube-mp3.org API, so in case that site gets shut down by Google the app will be useless. But let us all hope it stays afloat. :)

PS. I know about the piraty tint this app has, but I assure you that I didn't have anything of that kind in plans. The primary goal was to download a set of tracks that a guy played on floppy disks, as I found them very nice to listen to. And then I saw a couple of other videos - amateur covers of different songs - that I also wanted to have in a playlist on my iPhone.
