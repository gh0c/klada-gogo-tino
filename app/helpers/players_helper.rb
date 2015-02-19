module PlayersHelper

  # Returns the avatar for the player
  def avatar_for_player(player, options = { })

    cs = options[:cs] || {:w => 40, :h => 40}
    size = options[:size] || 40
    ct = options[:ct] || false
    custom_size = options[:custom_size] || false
    
    if ct
      if custom_size
        if (player.picture?)
          string = 
          "<div class = 'avatar avatar-size-custom'"+
          "style = 'background-image:url(\"#{player.picture.url}\");" +
          "width:#{cs[:w]}px; height:#{cs[:h]}px;'></div>"
          return string.html_safe
               
        else
          string = 
          "<div class = 'avatar avatar-size-custom'"+
          "style = 'background-image:url(\"/uploads/user/picture/basic.png\");" +
          "width:#{cs[:w]}px; height:#{cs[:h]}px;'></div>"
          return string.html_safe
        end
        
      else
        if (player.picture?)
          string = 
          "<div class = 'avatar avatar-size-std'"+
          "style = 'background-image:url(\"#{player.picture.url}\")'></div>"
          return string.html_safe
               
        else
          string = 
          "<div class = 'avatar avatar-size-std'"+
          "style = 'background-image:url(\"/uploads/user/picture/basic.png\")'></div>"
          return string.html_safe
        end
      end
    
    else
      if (player.picture?)
        image_tag(player.picture.url, alt: player.name, 
          class: "logo avatar-size-#{size}" )
             
      else
        image_tag("/uploads/user/picture/basic.png", alt: player.name, 
          class: "avatar avatar-size-#{size}")
      end
    end
  end
 
  
end