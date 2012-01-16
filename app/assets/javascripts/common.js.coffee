jQuery ($)->
  if $('.alert-message[data-close-after]').length > 0
    $('.alert-message[data-close-after]').each (i, a)->
      setTimeout(
        (-> $(a).find('a.close').trigger('click')), $(a).data('close-after')
      )