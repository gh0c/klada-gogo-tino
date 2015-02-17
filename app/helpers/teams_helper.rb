module TeamsHelper

  # Team logo
  def team_logo(team, options = { })
    

    cs = options[:cs] || {:w => 40, :h => 40}
    
    size = options[:size] || 40
    ct = options[:ct] || false
    custom_size = options[:custom_size] || false

    
    
    if ct
      if custom_size
        string = 
        "<div class = 'avatar avatar-size-custom'"+
        "style = 'background-image:url(\"#{team.logo.url}\");" +
        "width:#{cs[:w]}px; height:#{cs[:h]}px;'></div>"
        return string.html_safe
      else
        string = 
        "<div class = 'avatar avatar-size-std'"+
        "style = 'background-image:url(\"#{team.logo.url}\")'></div>"
        return string.html_safe
      end
    
    else
      if (team.logo?)
        image_tag(team.logo.url, alt: team.name, 
          class: "logo avatar-size-#{size}" )
             
      else
        image_tag("/uploads/team/picture/nba-logo.jpg", alt: team.name, 
          class: "avatar avatar-size-#{size}")
      end
    end

  end
  
end