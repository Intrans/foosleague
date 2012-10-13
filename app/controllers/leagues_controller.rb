class LeaguesController < InheritedResources::Base
  actions :create, :edit, :index, :new, :update

  def create
    create! { resource_url }
  end

  def update
    update! { resource_url }
  end

  protected

    def begin_of_association_chain
      current_player
    end

end
