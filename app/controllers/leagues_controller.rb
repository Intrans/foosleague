class LeaguesController < InheritedResources::Base
  actions :create, :index, :new

  def create
    create! { root_url }
  end

end
