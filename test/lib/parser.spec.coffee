"use strict"
Parser = require("../../src/lib/parser")
parse = new Parser
path = require("path")
fs = require("fs")

describe "Markdown Parser Test", ->
  markdownTestStr = ''

  before (done) ->
    markdownTestStr = "### Head\n" + "> 1. bq1\n" + "2. bq2\n"
    markdownTestStr += "3. bq3\n" + "\n\n"
    markdownTestStr += "테스트 주도 개발입니다\n" + "* 1. 1_li\n" + "* 2. 2_li\n"
    done()
    return

  after (done) ->

    #TODO : 생성된 파일 삭제 로직 필요
    done()
    return

  it "should parse h1 tag", (done) ->
    @timeout 1000
    h1 = parse.parse("# heading")
    h1.should.startWith "<h1"
    done()
    return

  it "should parse complex tag", (done) ->
    @timeout 1000
    h1 = parse.parse(markdownTestStr)
    h1.should.containEql "<h3"
    h1.should.containEql "<blockquote>"
    h1.should.containEql "<li>bq3</li>"
    h1.should.containEql "<p>"
    done()
    return

  # it "should save document body", (done) ->
  #   docPath = parser.save("테스트", "<p>테스트<p>")
  #   docPath.should.containEql "/store/"
  #   done()
  #   return
  #
  # it "should save document body after markdown parsing", (done) ->
  #   @timeout 1000
  #   h1 = parser.parse(markdownTestStr)
  #   docPath = parser.save(markdownTestStr, h1)
  #   docPath.should.containEql "/store/"
  #   done()
  #   return

  return
