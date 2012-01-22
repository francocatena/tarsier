jQuery ($)->
  if $('#c_articles').length > 0
    $('#article_tag_list').tagit
      allowSpaces: true,
      removeConfirmation: true,
      tagSource: (search, showChoices)->
        $.getJSON '/tags', {q: search.term}, (data)->
          showChoices $.map(data, (t)-> t.name)
          
    #$('#article_tag_list').next('ul.tagit').removeClass 'ui-widget-content'