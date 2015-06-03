module Risk::Game

  describe Attack do 

    describe ".rank_dice" do 

      it "returns an array" do 
        expect(Attack.rank_dice([5,3], [4,2])).to be_kind_of(Array)
      end

      it "returns an array of length of shorter argument array" do 
        expect(Attack.rank_dice([5,3,1], [4,2]).length).to be 2
      end

      it "returns the number of wins for the attacker" do 
        attacker_win, d = Attack.rank_dice([5,3], [4,4,4])
        expect(attacker_win).to be 1
      end

      it "returns the number of wins for the defender" do 
        a, defender_win = Attack.rank_dice([5,5,1], [6,5,1])
        expect(defender_win).to be 0
      end

    end

    describe ".roll_dice" do 

      it "returns an array" do 
        expect(Attack.roll_dice 2).to be_kind_of(Array)
      end

      it "returns an array of length equal to arguement" do 
        expect(Attack.roll_dice(2).length).to be 2
      end

    end

    describe ".run_attack" do 

      before :each do
        @action = AttackAction.new(1, 2, :alaska, :kamchatka, 3)
        @game = Game.new
        allow(@game).to receive(:armies_in).with(:kamchatka).and_return(1)
      end

      it "returns an array" do 
        expect(Attack.run_attack(@action, @game)).to be_kind_of(Array)
      end

      it "returns an array of length 2" do 
        expect(Attack.run_attack(@action, @game).length).to eq 2
      end
      
    end

  end
end