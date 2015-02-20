class Prediction < ActiveRecord::Base
  belongs_to :player, :inverse_of => :predictions
  has_one :team
  
  validates :player_id,  presence: true
  validates :team_id,  presence: true
  validates_inclusion_of :playoff, :in => [true, false]
  validates :position, :inclusion => { :in => 1..15, :message => " should be between 1 to 15" }
  validates :position, :presence => { :message => " cannot be blank" }
  validates :wins, :inclusion => { :in => 0..82, :message => " should be between 0 to 82" }
  validates :wins, :presence => { :message => " cannot be blank" }
  validates :losses, :inclusion => { :in => 0..82, :message => " should be between 0 to 82" }
  validates :losses, :presence => { :message => " cannot be blank" }
  
  
  validates :player_id, :uniqueness => { 
    :scope => :team_id, :message => " - already exists prediction for this team" }
  validates :position, :uniqueness => {
    :scope => [:player_id, :conference], 
    :message => " already taken in some other prediction for this conferece"
  }
  
  validate :sum_of_wins_losses
  validates :conference,  presence: true

  validate  :conferences_east_west
  
  
  private
  
    def sum_of_wins_losses
      if (wins && losses) && !(wins + losses == 82)
          errors.add(:base, "number of wins added to losses should be 82")
      end
      
    end
    
    def conferences_east_west
      if !(conference && (['east', 'west'].include? conference.downcase))
          errors.add(:conference, "should be either East or West")
      end
    end

  
end
