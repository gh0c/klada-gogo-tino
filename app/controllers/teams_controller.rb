class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user_confirm,     only: [:new, :edit, :update, :destroy,
                                                :standings, :update_standings]
  
  def index
    @teams = Team.all.order('conference, position')
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
  
  



  private

    def teams_params
      params.require(:team).permit(:name, :short_name, :link, :conference, :logo,
                                  :position, :playoff, :wins, :losses, :nickname)
    end
    

 
end
