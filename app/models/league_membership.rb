class LeagueMembership < ActiveRecord::Base
  belongs_to :league, :inverse_of => :league_memberships
  belongs_to :player, :inverse_of => :league_memberships

  validates_presence_of :league, :player

  validates_uniqueness_of :player_id, :scope => :league_id

  after_create :first_player_dude_is_the_admin

  has_one :true_skill, :as => :subject
  after_create :setup_true_skill

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
      return if league.players.count > 1
      self.admin = true
      self.save!
    end

    def setup_true_skill
      logger.info "Starting at: #{starting_skill}"
      self.build_true_skill(:skill => starting_skill)
      self.true_skill.save
    end
end
