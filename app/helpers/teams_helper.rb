module TeamsHelper

  # Team logo
  def team_logo(team, options = { size: 40 })

    if (team.logo?)
      image_tag(team.logo.url, alt: team.name, 
        class: "logo avatar-size-#{options[:size]}")
    else
      image_tag("/uploads/team/picture/nba-logo.jpg", alt: team.name, 
        class: "avatar avatar-size-#{options[:size]}")
    end
  end
  
end