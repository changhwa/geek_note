marked = require("marked")
renderer = new marked.Renderer()

marked.setOptions
  renderer: renderer
  gfm: true
  tables: true
  breaks: false
  pedantic: false
  sanitize: true
  smartLists: true
  smartypants: false

class Parser
  constructor: () ->
  parse: (markdownString) ->
    "use strict"
    marked markdownString

module.exports = Parser
