module Risk::Game

  describe AttackState do 
    before :each do 
      @attack_state = AttackState.new
    end

    describe ".allows?" do 
      it "returns true for AttackAction" do 
        action = AttackAction.new(1,2, :alaska, :kamchatka, 3)
        expect(@attack_state.allows? action).to be true
      end

      it "returns true for MoveAction" do 
        action = MoveAction.new(:alaska, :kamchatka, 4)
        expect(@attack_state.allows? action).to be true
      end

      it "returns true for NoMoveAction" do
        action = NoMoveAction.new
        expect(@attack_state.allows? action).to be true
      end

      it "returns false for PlaceAction" do
        action = PlaceAction.new(1, :kamchatka, 4)
        expect(@attack_state.allows? action).to be false
      end
    end

  end

end