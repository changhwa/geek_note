gitfs = require('gift')

class History
  constructor: () ->

  save: (docData, callback) ->
    _path = docData.doc_path
    splitIdx = _path.lastIndexOf "/"
    storePath = _path.substring(0,splitIdx)
    fileName = _path.substring(splitIdx+1, _path.length)
    _commit storePath, fileName, 'message', callback

  _commit = (path, fileName, message, callback) ->
    repo = gitfs path
    repo.add [fileName+".md",fileName+".html"], (err) ->
      repo.commit message, [], (err) ->
        repo.current_commit (err, _commitResult) ->
          callback _commitResult

module.exports = History