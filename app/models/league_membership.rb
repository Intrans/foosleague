class LeagueMembership < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :league, :inverse_of => :league_memberships
  belongs_to :player, :inverse_of => :league_memberships

  validates_presence_of :league, :player

  validates_uniqueness_of :player_id, :scope => :league_id

  after_create :first_player_dude_is_the_admin

  has_one :true_skill, :as=>:subject
  after_create :create_true_skill

  scope :by_skill, joins(:true_skill).order('skill desc')
  scope :by_league, lambda{|league_id| where(['league_id = ?', league_id])}

  def skill
    true_skill.skill
  end

  def deviation
    true_skill.deviation
  end

  def rating
    true_skill.rating
  end

  def update_rating(updated_rating)
    true_skill.update_attributes({:skill=>rating.mean, :deviation=>rating.deviation, :activity=>rating.activity})
  end

  private

    def first_player_dude_is_the_admin
      return if league.memberships.count > 1
      league.memberships.first.update_attributes(:admin => true)
    end

end
