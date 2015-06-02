module Risk

  module Game

    class AttackAction < Action

      attr_reader :attacker, :defender, :attacking_country, :defending_country,
                  :attack_with, :error_message

      attr_accessor :won

      def initialize(attacker_id, defender_id, attack_country, defending_country, 
                      attack_with)
        @attacker, @defender = attacker_id, defender_id
        @attacking_country, @defending_country = attack_country, defending_country
        @attack_with = attack_with
        @won = false
      end

      def execute_on(game)
        attacker_losses, defender_losses = Attack.run_attack(self, game)
        game.place_armies_in(attacking_country, -attacker_losses)
        game.place_armies_in(defending_country, -defender_losses)

        self.won = game.armies_in(defending_country) == 0
        game.won = self.won

        if game.won
          game.set_owner_of(defending_country, attacker)
          game.move_from = attacking_country
          game.move_to = defending_country
          if !game.assignment_map.values.include?(defender)
            game.remove_player(defender)
          end
        end
      end

      def valid_on?(game)
        if !Board.countries.include?(attacking_country) 
          @error_message = "#{attacking_country.to_s} does not exist."
        elsif !Board.countries.include?(defending_country) 
          @error_message = "#{defending_country.to_s} does not exist."
        elsif !Board.are_adjacent?(attacking_country, defending_country)
          @error_message = "Countries are not adjacent."
        elsif game.owner_of(attacking_country) != attacker
          @error_message = "You do not own #{attacking_country.to_s}."
        elsif game.owner_of(defending_country) != defender
          @error_message = "Defender does not own #{defending_country.to_s}."
        elsif attacker == defender
          @error_message = "You cannot attack your own country."
        elsif (game.armies_in(attacking_country) < (attack_with + 1))
          @error_message = "You cannot attack with more than #{game.armies_in(attacking_country) - 1} armies."
        elsif attack_with > 3
          @error_message = "You cannot attack with more than 3 armies."
        elsif attack_with < 1
          @error_message = "You must attack with at least 1 army."
        end

        @error_message == nil
      end

    end

  end

end