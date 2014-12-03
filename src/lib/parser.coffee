marked = require("marked")
renderer = new marked.Renderer()
path = require('path')
fs = require('fs')
mkdirp = require('mkdirp')
uuid = require('node-uuid')
moment = require('moment')

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
  save: (markdown, html) ->
    "use strict"
    storePath = path.resolve(__dirname, "../../") + "/store/"
    storePath += moment().format("YYYY") + "/" + moment().format("MM")
    storePath += "/" + moment().format("DD")
    fileName = uuid.v4()
    fileFullPathName = storePath + "/" + fileName
    mkdirp.sync storePath, ->
      mkdirp.sync storePath
      return
    @_save(markdown, html, fileFullPathName)
    fileFullPathName
  _save: (markdown, html, fileFullPathName) ->
    fs.writeFileSync fileFullPathName + ".md", markdown
    fs.writeFileSync fileFullPathName + ".html", html




module.exports = Parser