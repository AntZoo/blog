# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
path = require('path')

post_date_regex = new RegExp("([0-9]+-)*")

docpadConfig =
  # Template Data
  # =============
  # These are variables that will be accessible via our templates
  # To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ
  ignorePaths: [
    'render/drafts'
  ]

  templateData:

    # Specify some site properties
    site:
      # The production url of our website
      url: "http://anton.zujev.eu"

      # Here are some old site urls that you would like to redirect from
      #oldUrls: [
      #  'www.website.com',
      #  'website.herokuapp.com'
      #]

      # The default title of our website
      title: "Z"

      # The website description (for SEO)
      description: """
        Anton Zujev. Developer. Linguist. Nice fellow.
        Personal blog.
        """

      # The website keywords (for SEO) separated by commas
      keywords: """
        anton zujev, zujev, java, c++, informix, in da zoo, зоопарк, антон зуев, зуев, utan, podcast, подкаст
        """

      # The website author's name
      author: "Anton Zujev"

      # The website author's email
      email: "anton@zujev.eu"

      # Your company's name
      copyright: "© The Zujev"

    # Helper Functions
    # ----------------

    # Get the prepared site/document title
    # Often we would like to specify particular formatting to our page's title
    # we can apply that formatting here
    getPreparedTitle: ->
      # if we have a document title, then we should use that and suffix the site's title onto it
      if @document.title
        "#{@document.title} | #{@site.title}"
      # if our document does not have it's own title, then we should just use the site's title
      else
        @site.title

    getCopyright: ->
      "#{@site.copyright} #{@site.date.getFullYear()}"

    # Get the prepared site/document description
    getPreparedDescription: ->
      # if we have a document description, then we should use that, otherwise use the site's description
      @document.description or @site.description

    # Get the prepared site/document keywords
    getPreparedKeywords: ->
      # Merge the document keywords with the site keywords
      @site.keywords.concat(@document.keywords or []).join(', ')

    getCastA: ->
      switch @document.podfeed
        when 'indazoo' then "<a href='http://thezujev.com/sources/pods/zoo/#{@document.basename}.mp3' class='jouele'>#{@document.title}</a>"
        when 'utan' then "<a href='http://thezujev.com/sources/pods/utn/#{@document.basename}.mp3' class='jouele'>#{@document.title}</a>"
        when 'hot' then "<a href='http://thezujev.com/sources/pods/hot/#{@document.basename}.mp3' class='jouele'>#{@document.title}</a>"
        when 'cnt' then "<a href='http://thezujev.com/sources/pods/cnt/#{@document.basename}.mp3' class='jouele'>#{@document.title}</a>"
        else 'Podcast not found. Please <a href="mailto:anton@zujev.eu">contact me.</a>'

    getEnclosure: ->
      switch @document.podfeed
        when 'indazoo' then "<span id='feedburner'><a href='http://thezujev.com/sources/pods/zoo/#{@document.basename}.mp3' rel='enclosure'>#{@document.title}</a></span>"
        when 'utan' then "<span id='feedburner'><a href='http://thezujev.com/sources/pods/utn/#{@document.basename}.mp3' rel='enclosure'>#{@document.title}</a></span>"
        when 'hot' then "<span id='feedburner'><a href='http://thezujev.com/sources/pods/hot/#{@document.basename}.mp3' rel='enclosure'>#{@document.title}</a></span>"
        when 'cnt' then "<span id='feedburner'><a href='http://thezujev.com/sources/pods/cnt/#{@document.basename}.mp3' rel='enclosure'>#{@document.title}</a></span>"

    getCastImg: ->
      switch @document.podfeed
        when 'indazoo' then '/images/pod_indazoo.jpg'
        when 'utan' then '/images/pod_utan.jpg'
        when 'hot' then '/images/pod_hot.jpg'
        when 'cnt' then '/images/pod_cnt.jpg'
        else '/images/pod_generic.jpg'

  # Collections
  # ===========
  # These are special collections that our website makes available to us

  collections:
    # For instance, this one will fetch in all documents that have pageOrder set within their meta data
    pages: ->
      @getCollection("html").findAllLive({relativeOutDirPath:'p'}, [pageOrder:1,title:1]).on "add", (model) ->
        model.setMetaDefaults({layout:"page"})

    # This one, will fetch in all documents that will be outputted to the posts directory
    posts: ->
      @getCollection("html").findAllLive({relativeOutDirPath:'blog'},[date:-1]).on "add", (model) ->
        model.setMetaDefaults({layout:"post"})

    # This one, will fetch in all documents that will be outputted to the posts directory
    everything: ->
      @getCollection("html").findAllLive($or: {relativeOutDirPath:'blog', relativeOutDirPath:'cast'},[date:-1])

    # This one, will fetch in all documents that will be outputted to the podcasts directory
    podcasts: ->
      @getCollection("html").findAllLive({relativeOutDirPath:'cast'},[date:-1]).on "add", (model) ->
        model.setMetaDefaults({layout:"podcast"})

    indazoo: ->
      @getCollection("html").findAllLive({podfeed: $has: ['indazoo']},[date:-1])

    utan: ->
      @getCollection("html").findAllLive({podfeed: $has: ['utan']},[date:-1])

    hot: ->
      @getCollection("html").findAllLive({podfeed: $has: ['hot']},[date:-1])

    cnt: ->
      @getCollection("html").findAllLive({podfeed: $has: ['cnt']},[date:-1])

    russian: ->
      @getCollection("html").findAllLive({language: $has: ['russian']},[date:-1])

    english: ->
      @getCollection("html").findAllLive({language: $has: ['english']},[date:-1])

    swedish: ->
      @getCollection("html").findAllLive({language: $has: ['swedish']},[date:-1])

    czech: ->
      @getCollection("html").findAllLive({language: $has: ['czech']},[date:-1])

  # DocPad Events
  # =============

  # Here we can define handlers for events that DocPad fires
  # You can find a full listing of events on the DocPad Wiki
  events:

    # Server Extend
    # Used to add our own custom routes to the server before the docpad routes are added
    serverExtend: (opts) ->
      # Extract the server from the options
      {server} = opts
      docpad = @docpad

      # As we are now running in an event,
      # ensure we are using the latest copy of the docpad configuraiton
      # and fetch our urls from it
      latestConfig = docpad.getConfig()
      oldUrls = latestConfig.templateData.site.oldUrls or []
      newUrl = latestConfig.templateData.site.url

      # Redirect any requests accessing one of our sites oldUrls to the new site url
      server.use (req,res,next) ->
        if req.headers.host in oldUrls
          res.redirect 301, newUrl+req.url
        else
          next()

    renderBefore: (opts) ->
      docpad = @docpad

      posts = docpad.getCollection('posts')

      console.log('')
      count = 0

      posts.forEach (post) ->
        
        originalFilename = post.get('outFilename')
        console.log('**** ' + originalFilename)

        matches = /(\d\d\d\d)-(\d\d)-(\d\d)/.exec(originalFilename)
        return if matches.length != 4

        date = new Date(matches[1] + '-' + matches[2] + '-' + matches[3])

        newFilename = originalFilename.replace(post_date_regex, '')
        newOutPath = path.join(docpad.config.outPath, matches[1], newFilename)
        newUrl = '/' + matches[1] + '/' + newFilename

        originalUrl = post.get('originalUrl')
        throw 'Urls do not match "' + originalUrl + '" <-> "' + newUrl + '"' if originalUrl && originalUrl != newUrl

        post.set('outPath', newOutPath)
        post.setUrl(newUrl)

        count = count + 1

      console.log('Processed posts count: ' + count)
      console.log('')


# Export our DocPad Configuration
module.exports = docpadConfig
