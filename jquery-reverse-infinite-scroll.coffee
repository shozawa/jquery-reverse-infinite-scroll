do ($ = jQuery) ->
  check = ->
    distance = @scrollTop()
    if distance == 0
      nextLink = @find("[rel=next]")
      scrollHeight = @[0].scrollHeight
      $.getScript(nextLink.attr("href")).done =>
        diff = @[0].scrollHeight - scrollHeight
        @scrollTop(diff)

  methods = {
    init: ->
      @scrollTop(@[0].scrollHeight - @height())
      scrollHandler = (=>check.apply(@))
      scrollTimeout = null

      @scroll ->
        if scrollTimeout
          clearTimeout(scrollTimeout)
          scrollTimeout = null
        scrollTimeout = setTimeout(scrollHandler, 1500)
  }

  $.fn.reverseInfiniteScroll = (method) ->
    @each ->
      if methods[method]
        methods[method].apply($(@), Array.prototype.slice(arguments, 1))
      else if (typeof method == 'object' || ! method)
        methods.init.apply($(@), arguments)
      else
        $.error("an error has occured.")
