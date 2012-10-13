class PlayersController < InheritedResources::Base
  actions :create, :new
  belongs_to :league

  def create
    create! { parent_url }
  end

end
