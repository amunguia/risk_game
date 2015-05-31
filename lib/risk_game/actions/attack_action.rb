module Risk

  module Game

    class AttackAction < Action

      attr_reader :attacker, :defender, :attacking_country, :defending_country,
                  :attack_with
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

        self.won = attacker_losses < defender_losses
        game.won = self.won
      end

      def valid_on?(game)
        (attacker != defender) &&
        (attack_with > 0) &&
        (attack_with <= 3) &&
        (Board.countries.include? attacking_country) &&
        (Board.countries.include? defending_country) &&
        (Board.are_adjacent?(attacking_country, defending_country)) && 
        (game.owner_of(attacking_country) == attacker) &&
        (game.owner_of(defending_country) == defender) &&
        (game.armies_in(attacking_country) >= (attack_with + 1))
      end

    end

  end

end