require "risk_game/actions/action.rb"
require "risk_game/actions/attack_action.rb"
require "risk_game/actions/move_action.rb"
require "risk_game/actions/no_move_action.rb"
require "risk_game/actions/place_action.rb"
require "risk_game/actions/use_cards_action.rb"
require "risk_game/attack.rb"
require "risk_game/board.rb"
require "risk_game/cards.rb"
require "risk_game/exceptions.rb"
require "risk_game/game_include.rb"
require "risk_game/game.rb"
require "risk_game/states/state.rb"
require "risk_game/states/attack_state.rb"
require "risk_game/states/initial_place_state.rb"
require "risk_game/states/post_attack_move_state.rb"
require "risk_game/states/turn_start_after_cards_state.rb"
require "risk_game/states/turn_start_state.rb"
require "risk_game/version"

module RiskGame

  module Include

    # Dependency: attr_accessor 'army_map', 'assignment_map', 'players'
    #     'army_map'        - Hash(Symbol => Number)
    #     'assignment_map'  - Hash(Symbol => Number)
    #     'card_list'       - String -- (List of number, comma seperated)
    #     'cards'           - Array(Number)
    #     'max_place'       - Number
    #     'minimum_move'    - Number
    #     'players'         - Array(Number)
    #     'players_to_setup'- Number
    #     'state'           - State
    #     'won'             - Boolean

    def self.create_with_players(players)
      game = Game.new
      game.set_players players
      game.players_to_setup = players.length

      players.each do |p|
        game.set_cards_for_player(p, [])
      end

      game.assignment_map
      game
    end

    #attr_accessor :max_place, :minimum_move, :players_to_setup, :won

    INITIAL_ARMIES = 20

    def init
      self.max_place = INITIAL_ARMIES
      self.minimum_move = 0
      self.cards = {}
      self.card_list = Cards.card_list.join ","
      self.players = []
      self.players_to_setup = 0
      self.won = false
      initial_army_map
    end

    def play_action(action, game)
      if self.state.allows?(action) &&
        action.valid_on?(game)
        action.execute_on self.game
        self.state = state.update(action, self.game)
        self.state
      else
        false
      end
    end

    def armies_in(country)
      self.army_map[country]
    end

    def armies_for(player_id)
      Board.points_for self.assignment_map.select {|key, value| value == player_id}.keys
    end

    def assignment_map
      countries = Board.countries.shuffle
      ps = players

      self.assignment_map = {}
      countries.each do |country|
        self.assignment_map[country] = ps[0]
        ps = ps.drop(1) << ps[0]
      end
    end

    def cards_for_player(player_id)
      self.cards[player_id]
    end

    def current_player
      self.players[0]
    end

    def give_player_card
      cards = cards_for_player(current_player) << next_card
      set_cards_for_player(current_player, cards)
    end

    def next_card
      array = self.card_list.split ","
      self.card_list = array.drop(1).join ","
      array[0]
    end

    def next_player
      self.players = self.players.drop(1) << self.players.first
      current_player
    end

    def owner_of(country)
      self.assignment_map[country]
    end

    def place_armies_in(country, count)
      self.army_map[country] += count
    end

    def set_cards_for_player(player_id, cards)
      self.cards[player_id] = cards
    end

    def set_players(players)
      self.players = players
    end

    private 

    def initial_army_map
      countries = Board.countries
      self.army_map = {}
      countries.each do |country|
        army_map[country] = 1
      end
    end

  end 

end
