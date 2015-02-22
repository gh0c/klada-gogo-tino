class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  
  
  def update_standings
    require 'open-uri'
    @html_standings_doc = "--None--"
    url = "http://www.nba.com/standings/team_record_comparison/conferenceNew_Std_Cnf.html"
    doc = Nokogiri::HTML(open(url))
    
    rows = doc.css("table.genStatTable tr")
    
    all_teams = Team.all
    teams = Hash.new
  
    
    team_pos = 0
    
    rows.each do |row|
      if row.css("td.team").size > 0
        
        team_pos += 1
        team_name = row.css("td.team a")[0]['href'][1..-1]
        team_wins = row.css("td")[1].text.to_i
        team_losses = row.css("td")[2].text.to_i

        team_playoff = ((1..8).include? row.css("td.team sup.super")[0].text.to_i) ? true : false
        
        teams[team_name] = {:pos => team_pos, :w => team_wins,
                            :l => team_losses, :po => team_playoff } 
        
        
      elsif row.css("td.confTitle").size > 0
        team_pos = 0
      end
    end
    
    all_teams.each do |team|
      
      begin 
        team.update_attributes(position: teams[team.short_name][:pos],
                               wins: teams[team.short_name][:w],
                               losses: teams[team.short_name][:l],
                               playoff: teams[team.short_name][:po])
      rescue
        puts "error while updating for #{team.short_name}"
      end
    end
  end
  
  
  def update_players_points
    players = Player.all
    players.each do |player|
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
        total_pts += points 
      end
      player.update_attributes(points: total_pts)
    end
  end
  
  
  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
       
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "U're not correct user to complete wanted action"
        redirect_to(root_url) 
      end
    end
    
    def admin_or_correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "Only admin or correct user can do"
        redirect_to(root_url) 
      end
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    
    def admin_user_confirm
      unless current_user.admin?
        flash[:danger] = "U're not admin to complete wanted action"
        redirect_to(root_url) 
      end
    end
      
end
