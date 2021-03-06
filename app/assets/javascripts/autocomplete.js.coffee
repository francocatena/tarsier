jQuery ($)->
  $(document).on 'change', 'input.autocomplete', ->
    if /^\s*$/.test($(this).val())
      $(this).next('input.autocomplete_id:first').val('')
      
  $(document).on 'focus', 'input.autocomplete:not([data-observed])', ->
    input = $(this)

    input.autocomplete
      source: (request, response)->
        $.ajax
          url: input.data('autocompleteUrl')
          dataType: 'json'
          data: { q: request.term }
          success: (data)->
            response $.map data, (item)->
              content = $('<div></div>')
              value = item.label || item.name

              content.append $('<span></span>').text(value)

              if item.informal
                content.append(
                  $('<span class="informal"></span>').text(item.informal)
                )

              { label: content.html(), value: value, item: item }
      type: 'get'
      select: (event, ui)->
        selected = ui.item

        input.val(selected.value)
        input.data('item', selected.item)
        input.next('input.autocomplete_id').val(selected.item.id)

        input.trigger 'autocomplete:update', input

        false
      open: -> $('.ui-menu').css('width', input.width())

    input.data('autocomplete')._renderItem = (ul, item)->
      $('<li></li>').data('item.autocomplete', item).append(
        $('<a></a>').html(item.label)
      ).appendTo(ul)
  .attr('data-observed', true)