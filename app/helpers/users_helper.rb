module UsersHelper

  # Returns the avatar for the given user.
  def avatar_for(user, options = { })

    cs = options[:cs] || {:w => 40, :h => 40}
    size = options[:size] || 40
    ct = options[:ct] || false
    custom_size = options[:custom_size] || false
    
    if ct
      if custom_size
        if (user.picture?)
          string = 
          "<div class = 'avatar avatar-size-custom'"+
          "style = 'background-image:url(\"#{user.picture.url}\");" +
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
        if (user.picture?)
          string = 
          "<div class = 'avatar avatar-size-std'"+
          "style = 'background-image:url(\"#{user.picture.url}\")'></div>"
          return string.html_safe
               
        else
          string = 
          "<div class = 'avatar avatar-size-std'"+
          "style = 'background-image:url(\"/uploads/user/picture/basic.png\")'></div>"
          return string.html_safe
        end
      end
    
    else
      if (user.picture?)
        image_tag(user.picture.url, alt: user.name, 
          class: "logo avatar-size-#{size}" )
             
      else
        image_tag("/uploads/user/picture/basic.png", alt: user.name, 
          class: "avatar avatar-size-#{size}")
      end
    end
  end
 
 
  # Special avatar for header1
  def header_avatar_for(user, options = { size: 80 })

    if (user.picture?)
      image_tag(user.picture.url, alt: user.name, 
        class: "avatar header avatar-size-#{options[:size]}")
    else
      image_tag("/uploads/user/picture/basic.png", alt: user.name, 
        class: "avatar avatar-size-#{options[:size]}")
    end
  end
  
end