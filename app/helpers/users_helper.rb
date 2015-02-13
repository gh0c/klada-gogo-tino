module UsersHelper

  # Returns the Gravatar for the given user.
  def avatar_for(user, options = { size: 80 })

    if (user.picture?)
      image_tag(user.picture.url, alt: user.name, 
        class: "avatar avatar-size-#{options[:size]}")
    else
      image_tag("/uploads/user/picture/basic.png", alt: user.name, 
        class: "avatar avatar-size-#{options[:size]}")
    end
  end
  
end