class PlayersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user_confirm,     only: [:new, :edit, :update, :destroy]
  
  def index
    @players = Player.all
  end
  
  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end
  
  def destroy
    Player.find(params[:id]).destroy
    flash[:success] = "Player deleted"
    redirect_to players_url
  end
  
  
  def predictions
    @player = Player.find(params[:player_id])
    
    teams_east = @player.predictions.where("conference = ?", "east").order(:position)
    teams_west = @player.predictions.where("conference = ?", "west").order(:position)
 
    @player_predictions = {"East" => teams_east, "West" => teams_west}
  end
  
  
  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:success] = "Player created!"
      redirect_to players_url
    else
      render 'new'
    end
  end
  
  def edit
    @player = Player.find(params[:id])
  end
  
  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(player_params)
      flash[:success] = "Player updated"
      redirect_to player_url
    else
      render 'edit'
    end
  end

  private

    def player_params
      params.require(:player).permit(:name, :points, :picture)
    end
    

 
end
