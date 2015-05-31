module Risk

  module Game

    module Attack

      @random = Random.new

      def self.rank_dice(attacker_dice, defender_dice)
        a_length, d_length = attacker_dice.length, defender_dice.length
        shorter_length = (a_length < d_length)? a_length : d_length
        
        wins = [0,0]
        shorter_length.times do |i|
          if (attacker_dice[i] > defender_dice[i])
            wins[1] += 1
          else
            wins[0] += 1
          end
        end

        wins
      end

      def self.roll_dice(number)
        dice = []
        number.times do |i|
          dice << (@random.rand(6) + 1)
        end
        dice.sort.reverse
      end

      def self.run_attack(action, game) 
        defend_with = game.armies_in(action.defending_country) > 1? 2 : 1
        rank_dice(roll_dice(action.attack_with) ,roll_dice(defend_with))
      end

    end

  end

end