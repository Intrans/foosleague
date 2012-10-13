class LeaguesController < ApplicationController
  actions :create, :index, :new

  def create
    create! { root_url }
  end

end
