module Risk

  module Game

    class AttackState < State

      def allows?(action) 
        type = action.class
        
        type.eql?(AttackAction) ||
        type.eql?(MoveAction) ||
        type.eql?(NoMoveAction)
      end

      def update(action, game)
        case action.class.to_s
        when "Risk::Game::AttackAction"
          update_attack(action, game)
        when "Risk::Game::MoveAction",
             "Risk::Game::NoMoveAction"
          if game.won
            game.give_player_card
          end

          game.next_player
          game.won = false
          TurnStartState.new
        else
          nil
        end
      end

      def update_attack(action, game)
        if (action.won)
          game.minimum_move = action.attack_with
          PostAttackMoveState.new
        else
          self
        end
      end

    end

  end

end