module ApplicationHelper
  def show_error_messages_for(model)
    render 'shared/error_messages', model: model unless model.errors.empty?
  end
  
  def pagination_links(objects, params = nil)
    result = will_paginate objects, inner_window: 1, outer_window: 1,
      params: params, renderer: BootstrapLinkRenderer
    
    unless result
      previous_tag = content_tag(
        :li,
        link_to(t('will_paginate.previous_label').html_safe, '#'),
        class: 'prev disabled'
      )
      next_tag = content_tag(
        :li,
        link_to(t('will_paginate.next_label').html_safe, '#'),
        class: 'next disabled'
      )
      
      result = content_tag(
        :div,
        content_tag(
          :ul, previous_tag + content_tag(:li, link_to('1', '#'), class: 'active') + next_tag
        ), class: 'pagination'
      )
    end

    result
  end
end
