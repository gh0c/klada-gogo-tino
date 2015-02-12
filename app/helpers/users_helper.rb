module UsersHelper

  # Returns the Gravatar for the given user.
  def avatar_for(user, options = { size: 80 })
    avatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    avatar_url = "https://secure.gravatar.com/avatar/#{avatar_id}?s=#{size}"
    image_tag(avatar_url, alt: user.name, class: "gravatar")
  end
  
end