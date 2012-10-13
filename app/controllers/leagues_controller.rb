class LeaguesController < InheritedResources::Base
  actions :create, :index, :new

  def create
    create! { resource_url }
  end

  protected

    def begin_of_association_chain
      current_player
    end

end
