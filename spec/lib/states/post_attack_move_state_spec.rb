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

      it "returns false if move action does not have source == move_from" do 

      end

    end

    describe ".update" do
      before :each do 
        @game = Game.new
        @game.minimum_move = 3

        @action = MoveAction.new(1, :kamchatka, 3)
      end

      it "returns an AttackState" do
        expect(@state.update(@action, @game)).to be_kind_of(AttackState)
      end

      it "set minimum_move to 0" do
        @state.update(@action, @game)
        expect(@game.minimum_move).to be 0
      end
    end

  end

end