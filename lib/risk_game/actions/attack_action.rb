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

    end

  end

end