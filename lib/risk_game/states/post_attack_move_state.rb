module Risk

  module Game

    class PostAttackMoveState < State 

      def allows?(action)
        type = action.class 

        type.eql? MoveAction
      end

    end

  end

end