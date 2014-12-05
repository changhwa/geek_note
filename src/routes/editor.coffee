express = require("express")
parse = require("../../src/lib/parser")
Document = require("../../src/lib/document")
router = express.Router()

# GET home page.
router.get "/", (req, res) ->
  res.render "editor/editor"
  return

router.post "/preview", (req,res) ->
  parse = new Parser
  res.send {html : parse.parse req.body.content}

router.post "/save", (req,res) ->
  doc = new Document
  data = {}
  data.doc_content = req.body.content
  doc.saveDoc data, () ->
    res.send {status: 'OK'}

module.exports = router
