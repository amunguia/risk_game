module Risk

  module Game

    class AttackAction < Action

      attr_reader :attacker, :defender, :attacking_country, :defending_country,
                  :attack_with

      def initialize(attacker_id, defender_id, attack_country, defending_country, 
                      attack_with)
        @attacker, @defender = attacker_id, defender_id
        @attacking_country, @defending_country = attack_country, defending_country
        @attack_with = attack_with
      end

      def valid_on?(game)
        (attacker != defender) &&
        (attack_with > 0) &&
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