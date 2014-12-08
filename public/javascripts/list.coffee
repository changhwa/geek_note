'use strict'
class List
  constructor: () ->
  init: () ->
    List::event().getArticleList()
  event: () ->
    getArticleList: () ->
      $.ajax
        type: 'get'
        url: '/document/article',
        dataType: 'json',
        success: (_result) ->
          source = $("#article_list_template").html()
          template = Handlebars.compile(source)
          html = template(_result)
          $("#article_list").append(html)

jQuery ->
  window.List = new List()
  return