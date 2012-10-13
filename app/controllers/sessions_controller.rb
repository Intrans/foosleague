class SessionsController < Devise::SessionsController
  respond_to :html

  skip_before_filter :authorized?
  skip_before_filter :authenticate_player!

  prepend_view_path 'app/views/devise'

end
