---
title: "Octopress on Windows"
date: 2014-01-29 15:05
comments: false
tags: cmd
language: english
keywords: anton zujev, antzoo, zujev, octopress, windows, ssh, utf, bundler
description: Problems with using Octopress on Windows
---

I'd like to dedicate this post to the long hours I spent in trying to make Octopress work with Windows. As it was the second time I'm doing it I thought I might as well document all that I did to succeed.

I finally had an idea for a blog post (in Russian though, so don't get your hopes up), but when I tried updating the site I found out that I haven't reinstalled Octopress since I got a new PC. Here's what you have to do for the magic to happen.

0. Almost forgot to mention that you should have a functioning git and an executable ssh on the PC. I won't cover those, but I can tell you that I prefer installing cygwin with a plethora of enables applications and then just put the cygwin 'bin' folder in my PATH env.variable.

1. Install Ruby. I didn't really repeat this step, so I don't remember 100%. But in the nutshell you should go to [RubyInstaller for Windows](http://rubyinstaller.org/downloads/) page and download a) Ruby 1.9.3 and b) DevKit for Ruby 1.9.3. Next: install Ruby and DevKit. Once you unzip the latter (make sure you unzip to a permanent location where it will stay), fire up the command line, check if Ruby itself installed succefully (`ruby --version`) and then run, consecutively, `ruby dk.rb init` and `ruby dk.rb install`. You might also want to check in between whether config.yml really contains the path to your Ruby installation.

2. Go to [Octopress Docs](http://octopress.org/docs/setup/) and use the git command there to clone the Octopress source to your preferred folder. Next, run the `gem install bundler`. Now the fun part begins. Once that completes, try `bundle install`. If your passed, consider yourself lucky. Mine didn't, telling me that ffi 1.0.11 failed to install. After googling the error for a couple of hours (I'm not that proficient in either Ruby or Jekyll), I found out that ffi 1.0.10+ doesn't work well with Windows. So what you want to do is open the Gemfile.lock in your cloned blog directory and modify the line that says `ffi (1.0.11)` so that it says `ffi (1.0.9)`. Save, `bundle install` and you should be all set now.

3. The next problem I ran into was with the languages. My posts in Russian just wouldn't pass the `rake generate` part of the process. Apparently, even though I was saving them in utf-8 they somehow were interpreted as being written in some other weird codepage. So, to fix this, open your environment variables (I think it's right click on My computer, then properties, then configure system preferences. Or something like this - I've a Czech interface at work, I don't know) and create two new variables: LANG and LC_CTYPE. Set both to "en_US.UTF-8", without quotes. It's utf-8, so the en_US part doesn't really matter as far as I know. 

4. To deploy via ssh and use key auth you should go to your blog directory and edit your Rakefile. You should edit the task called rsync. In my case (I am using Octopress via Dropbox on both a PC and a Mac) I created a copy of rsync and called it winsync. All you have to do is ass `-i path/to/your/private/key' in the ssh command so that it looks like this: `ok_failed system("rsync -avze 'ssh -p #{ssh_port} -i path/to/key #{exclude} --chmod=u+rwX,g+rX,o+rX,g-w,o-w #{"--delete" unless rsync_delete == false} #{public_dir}/ #{ssh_user}:#{document_root}")` or something along those lines. I think I also at some point added the --chmod part because otherwise the uploaded site didn't have the right permissions, but I'm not sure if I did.

After that you're all set. Run `rake install` to install the default theme and start writing and publishing.
