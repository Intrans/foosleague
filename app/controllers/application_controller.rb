class ApplicationController < ActionController::Base

  helper_method :current_league, :league_menu_label, :league_logo, :player_avatar, :team_logo

  inherit_resources

  protect_from_forgery

  protected

    def after_sign_in_path_for(resource)
      case resource.leagues.count
      when 0
        new_league_url
      when 1
        league_url(resource.leagues.first)
      else
        last_game = resource.games.last
        last_game.present? ? league_url(last_game.league) : league_url(resource.leagues.last)
      end
    end

    def current_league
      nil
    end

    def current_team
      nil
    end

    def league_menu_label
      current_league.present? ? current_league.name : 'League Menu'
    end

    def league_logo(league = current_league, geometry = '50x50#')
      return Dragonfly[:images].fetch_file("#{Rails.root}/app/assets/images/default-league-logo.png").process(:thumb, geometry).url if league.nil? || league.logo_uid.blank?
      league.logo.process(:thumb, geometry).url
    end

    def player_avatar(player = current_player, geometry = '50x50#')
      return Dragonfly[:images].fetch_file("#{Rails.root}/app/assets/images/default-player-logo.png").process(:thumb, geometry).url if player.nil?
      #player.avatar.process(:thumb, geometry).url
      player.avatar_url
    end

    def team_logo(team = current_team, geometry = '50x50#')
      return Dragonfly[:images].fetch_file("#{Rails.root}/app/assets/images/default-team-logo.png").process(:thumb, geometry).url if team.nil?
      team.logo.process(:thumb, geometry).url
    end

end
