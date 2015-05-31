module Risk::Game

  describe PostAttackMoveState  do
    before :each do 
      @state = PostAttackMoveState.new
    end
      
    describe ".allows?" do
      it "returns true for MoveAction" do 
        action = MoveAction.new(:alaska, :kamchatka, 4)
        expect(@state.allows? action).to be true
      end

      it "returns false for any other action" do 
        action = NoMoveAction.new
        expect(@state.allows? action).to be false
      end

    end

  end

end