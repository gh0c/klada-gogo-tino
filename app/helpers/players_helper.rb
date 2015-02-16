module PlayersHelper

  # Returns the avatr for the given user.
  def avatar_for_player(player, options = { size: 80 })

    if (player.picture?)
      image_tag(player.picture.url, alt: player.name, 
        class: "avatar avatar-size-#{options[:size]}")
    else
      image_tag("/uploads/user/picture/basic.png", alt: player.name, 
        class: "avatar avatar-size-#{options[:size]}")
    end
  end
  
end