class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def standings
    require 'open-uri'
    @html_standings_doc = "--None--"
    url = "http://www.nba.com/standings/team_record_comparison/conferenceNew_Std_Cnf.html"
    doc = Nokogiri::HTML(open(url))

    doc2 = Nokogiri::HTML('<html><body><table></table></body></html>')
    doc2_table = doc2.at('table')
    
    tr = doc.css('.genStatTable .confTitle').first.parent
    while tr do
      doc2_table.add_child(tr.to_html) 
      tr = tr.next
    end
    @html_standings_doc = doc2.at('table').inner_html.html_safe
  end
  
  
  def bets_standings
    last_updated_team = Team.limit(1).order('updated_at desc').first
    @last_updated_team = last_updated_team.updated_at
    
    last_updated_player = Player.limit(1).order('updated_at desc').first
    @last_updated_player = last_updated_player.updated_at
    
    @teams = Team.all.order(conference: :asc, position: :asc)
    players = Player.all.order(points: :desc)
    @players_points = []
    players.each do |player|
      bets = {}
      total_pts = 0
      player.predictions.each do |prediction|
        team = Team.find(prediction.team_id)
        points = 0
        if prediction.position == team.position
          points += 1
        end
        if prediction.playoff == true && team.playoff == true
          points += 1
        end
        if prediction.wins == team.wins && prediction.losses == team.losses
          points += 3
        end
        bets[team.short_name] = {:points => points, :prediction => prediction.id}
        total_pts += points 
      end
      #player.update_attributes(points: total_pts)
      @players_points << [player, bets]
    end
  end
  
  
  
  
  def update_all_standings_ajax
    puts "------------call"

    update_standings
    update_players_points
    
    bets_standings
    
    
    respond_to do |format|
      format.html { redirect_to bets_standings_path }
      format.js
    end
  end
  
  
end

