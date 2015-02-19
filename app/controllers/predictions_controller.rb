class PredictionsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :admin_user_confirm,     only: [:new, :edit, :update, :destroy]

  def new
    @player = Player.find(params[:player_id])
    @prediction = Prediction.new
  end
  
  
  def create
    if team = Team.where(:id => prediction_params[:team_id]).first
      if @player = Player.where(:id => prediction_params[:player_id]).first
        @prediction = @player.predictions.build(
                      prediction_params.merge(:conference => team.conference))
                      
        if @prediction.save
          flash[:success] = "Prediction created!"
          redirect_to "/players/#{prediction_params[:player_id]}/predictions"
        else
          render "new"
        end
      else
        @prediction.errors << "Wrong player"
        render 'new'
      end
    else
      render 'new'
    end
  end
  

  
  def edit
    @prediction = Prediction.find(params[:id])
    @player = @prediction.player
  end
  
  def update
    if team = Team.where(:id => prediction_params[:team_id]).first
      if @player = Player.where(:id => prediction_params[:player_id]).first
 
        @prediction = Prediction.find(params[:id])
        if @prediction.update_attributes(
                      prediction_params.merge(:conference => team.conference))

          flash[:success] = "Prediction updated!"
          redirect_to "/players/#{prediction_params[:player_id]}/predictions"
        else
          render "edit"
        end
      else
        @prediction.errors << "Wrong player"
        render 'edit'
      end
    else
      render 'edit'
    end
  end
  

  def destroy
    p = Prediction.find(params[:id])
    p.destroy
    flash[:success] = "Prediction deleted"
    redirect_to "/players/#{p.player.id}/predictions"
  end


  private

    def prediction_params
      params.require(:prediction).permit( :player_id, :team_id, :playoff, :wins,
                                          :losses, :conference, :position)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
