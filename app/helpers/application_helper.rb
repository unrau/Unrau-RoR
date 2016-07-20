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

  def render_markdown(markdown)
    context = {
      :asset_root => "#{request.base_url}/images/" # public images path for EmojiFilter
    }

    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::YoutubeFilter,
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter
    ], context

    result = pipeline.call markdown
    return result[:output].to_s.html_safe
  end

end
