class RegistrationsController < Devise::RegistrationsController
  respond_to :html

  skip_before_filter :authorized?, :only => [ :create, :new ]
  skip_before_filter :authenticate_player!, :only => [ :create, :new ]

  prepend_view_path 'app/views/devise'
end
