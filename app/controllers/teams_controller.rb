class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user_confirm,     only: [:new, :edit, :update, :destroy,
                                                :standings, :update_standings]
  
  def index
    @teams = Team.all
  end
  
  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end
  
  def destroy
    Team.find(params[:id]).destroy
    flash[:success] = "Team deleted"
    redirect_to teams_url
  end
  
  
  def create
    @team = Team.new(teams_params)
    if @team.save
      flash[:success] = "Team created!"
      redirect_to teams_url
    else
      render 'new'
    end
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(teams_params)
      flash[:success] = "Team updated"
      redirect_to teams_url
    else
      render 'edit'
    end
  end
  
  
  def standings
    #update_standings
    
    last_updated_team = Team.limit(1).order('updated_at desc').first
    @last_update = last_updated_team.updated_at
    
    
    teams_east = Team.where("conference = ?", "east").order(:position)
    teams_west = Team.where("conference = ?", "west").order(:position)
 
    @all_teams = {"East" => teams_east, "West" => teams_west}
    
  end
  
  
  def update_standings_ajax

    update_standings
    standings
    
    respond_to do |format|
      format.html { redirect_to standings_path }
      format.js
    end
  end
  
  
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


  private

    def teams_params
      params.require(:team).permit(:name, :short_name, :link, :conference, :logo,
                                  :position, :playoff, :wins, :losses, :nickname)
    end
    

 
end
