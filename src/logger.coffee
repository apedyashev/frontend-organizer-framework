window.Rrs ?= {}

Rrs.logger =
  error: ->
    console.error.apply console, arguments

  log: ->
    console.log.apply console, arguments

  debug: ->
    console.debug.apply console, arguments