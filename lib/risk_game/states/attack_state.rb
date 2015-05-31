module Risk

  module Game

    class AttackState < State

      def allows?(action) 
        type = action.class
        
        type.eql?(AttackAction) ||
        type.eql?(MoveAction) ||
        type.eql?(NoMoveAction)
      end

    end

  end

end