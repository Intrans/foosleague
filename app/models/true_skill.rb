class TrueSkill < ActiveRecord::Base
  include Saulabs
  
  # has_paper_trail :on => [:create, :update]
  belongs_to :subject, :polymorphic => true
  
  attr_accessible :skill, :deviation, :activity

  def rating
    @rating ||= TrueSkill::Rating.new(skill, deviation, activity)
  end
end