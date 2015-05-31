module Risk

  module Game

    class PostAttackMoveState < State 

      def allows?(action)
        type = action.class 
        type.eql? MoveAction
      end

      def update(action, game)
        game.minimum_move = 0
        AttackState.new
      end

    end

  end

end