class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user_confirm,     only: [:new, :edit, :update, :destroy]
  
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

  private

    def teams_params
      params.require(:team).permit(:name, :short_name, :link, :conference, :logo,
                                  :position, :playoff, :wins, :losses)
    end
    

 
end
