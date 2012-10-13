class SessionsController < Devise::SessionsController
  respond_to :html
  
  skip_before_filter :authorized?
  skip_before_filter :authenticate_player!

  layout :specify_layout

  prepend_view_path 'app/views/devise'

  protected
    def specify_layout
      controller_name == 'sessions' && (action_name == 'new' || action_name == 'create')  ? 'layouts/auth' : 'layouts/application'
    end

end
