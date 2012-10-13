class PasswordsController < Devise::PasswordsController
  skip_before_filter :authorized?
  skip_before_filter :authenticate_player!

  respond_to :html

  prepend_view_path 'app/views/devise'
end
