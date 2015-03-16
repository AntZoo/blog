$ ->
  $('pre').addClass('prettyprint')
  prettyPrint()

  $('iframe').each ->
    $(this).wrap('<div class="embed-video-container"></div>')