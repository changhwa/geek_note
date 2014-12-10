Remarkable = require('remarkable');
md = new Remarkable('full');
path = require('path')
fs = require('fs')
mkdirp = require('mkdirp')
uuid = require('node-uuid')
moment = require('moment')

"use strict"
class Parser

  storePath = path.resolve(__dirname, "../../") + "/store/"
  storePath += moment().format("YYYY") + "/" + moment().format("MM")
  storePath += "/" + moment().format("DD")
  fileName = uuid.v4()

  constructor: () ->
  parse: (markdownString, callback) ->
    callback md.render markdownString
  save: (markdown, html, callback) ->
    fileFullPathName = storePath + "/" + fileName
    mkdirp.sync storePath, ->
      mkdirp.sync storePath
      return
    @_save(markdown, html, fileFullPathName)
    callback fileFullPathName
  update: (markdown, html, fileFullPathName, callback) ->
    @_save markdown, html, fileFullPathName
    callback filePullPathName
  _save: (markdown, html, fileFullPathName) ->
    fs.writeFileSync fileFullPathName + ".md", markdown
    fs.writeFileSync fileFullPathName + ".html", html

module.exports = Parser
