class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    player = Player.from_omniauth(request.env["omniauth.auth"])
    if player.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect player
    else
      session["devise.player_attributes"] = player.attributes
      redirect_to new_player_registration_url
    end
  end

  alias_method :twitter, :all
end
