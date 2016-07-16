module ApplicationHelper

  def title(page_title, hide_base=false)
    base_title = 'Website Title'
    if page_title.length > 0
      if hide_base
        base_title = page_title.to_s
      else
        base_title = base_title + ' - ' + page_title.to_s
      end
    end
    provide :title, base_title
  end

end
