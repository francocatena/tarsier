module ApplicationHelper
  def show_error_messages_for(model)
    render 'shared/error_messages', model: model unless model.errors.empty?
  end
  
  def pagination_links(objects, params = nil)
    result = will_paginate objects, inner_window: 1, outer_window: 1,
      params: params
    
    unless result
      previous_tag = content_tag(
        :span,
        t('will_paginate.previous_label').html_safe,
        class: 'disabled prev_page'
      )
      next_tag = content_tag(
        :span,
        t('will_paginate.next_label').html_safe,
        class: 'disabled next_page'
      )
      
      result = content_tag(
        :div,
        previous_tag + content_tag(:em, 1) + next_tag,
        class: 'pagination'
      )
    end

    result
  end
end
