module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Kladara"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  
  # Returns picture div HTML code for the given URL
  def picture_for(url, options = { })

    cs = options[:cs] || {:w => 40, :h => 40}
    custom_size = options[:custom_size] || false
    
    if custom_size
      string = 
      "<div class = 'picture picture-size-custom'"+
      "style = 'background-image:url(\"#{url}\");" +
      "width:#{cs[:w]}px; height:#{cs[:h]}px;'></div>"
      return string.html_safe
    else
      string = 
      "<div class = 'picture picture-size-std'"+
      "style = 'background-image:url(\"#{url}\")'></div>"
      return string.html_safe
    end

  end
  

end