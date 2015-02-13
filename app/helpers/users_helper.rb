module UsersHelper

  # Returns the Gravatar for the given user.
  def avatar_for(user, options = { size: 80 })

    image_tag(user.picture.url, alt: user.name, class: "gravatar")
    
  end
  
end