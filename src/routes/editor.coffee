express = require("express")
Parser = require("../../src/lib/parser")
router = express.Router()

# GET home page.
router.get "/", (req, res) ->
  res.render "editor/editor"
  return

router.post "/preview", (req,res) ->
  parse = new Parser
  res.send {html : parse.parse req.body.content}

router.post "/save", (req,res) ->
  parse = new Parser
  markdownContent = req.body.content
  htmlContent = parse.parse(markdownContent)
  docPath = parse.save(markdownContent, htmlContent)
  # TODO : 예외처리가 필요한데..
  res.send {status: 'OK'}

module.exports = router
