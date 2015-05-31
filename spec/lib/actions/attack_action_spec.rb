module Risk::Game

  describe AttackAction do 

    before :each do 
      @attack_action = AttackAction.new(1, 2, :alaska, :kamchatka, 3)
    end 

    describe ".attacker" do 
      it "returns the correct attacker id" do 
        expect(@attack_action.attacker).to be 1
      end
    end

    describe ".attacking_country" do 
      it "returns the correct attacking country" do 
        expect(@attack_action.attacking_country).to be :alaska
      end
    end

    describe ".attack_with" do 
      it "returns the correct attack with attribute" do 
        expect(@attack_action.attack_with).to be 3
      end
    end

    describe ".defender" do     
      it "returns the correct defender id" do 
        expect(@attack_action.defender).to be 2
      end
    end

    describe ".defending_country" do 
      it "returns the correct defending country" do 
        expect(@attack_action.defending_country).to be :kamchatka
      end
    end

    describe ".won" do 
      it "returns win status" do 
        expect(@attack_action.won).to be false
      end
    end

    describe ".execute_on" do 
      before :each do 
        @game = Game.new
        @game.place_armies_in(:alaska, 10)
        @game.place_armies_in(:kamchatka, 2)

        allow(Attack).to receive(:run_attack).and_return([1,1])
      end

      it "decreases the attacking countries armies by number of losses" do 
        @attack_action.execute_on(@game)
        expect(@game.armies_in :alaska).to be (9)
      end

      it "decreases the defending countries armeis by number of losses" do 
        @attack_action.execute_on(@game)
        expect(@game.armies_in :kamchatka).to be (1)
      end

      it "sets attack.won to true if the attacker wins" do
        allow(Attack).to receive(:run_attack).and_return([1,2])
        @attack_action.execute_on @game
        expect(@game.won).to be true
      end

      it "it sets game.won to true if attacker wins" do 
        allow(Attack).to receive(:run_attack).and_return([1,2])
        @attack_action.execute_on @game
        expect(@attack_action.won).to be true
      end
    end

    describe ".valid_on?" do 

      before :each do 
        @game = Game.new
        allow(@game).to receive(:owner_of).with(:alaska).and_return(1)
        allow(@game).to receive(:owner_of).with(:kamchatka).and_return(2)
        allow(@game).to receive(:armies_in).with(:alaska).and_return(10)
      end

      context "when valid" do 
        it "returns true" do 
          expect(@attack_action.valid_on? @game).to be true
        end
      end

      context "when invalid" do 

        it "returns false if countries are not adjacent" do 
          action = AttackAction.new(1, 2, :alaska, :argentina, 3)
          expect(action.valid_on? @game).to be false
        end

        it "returns false if attacker does not own attacking country" do 
          allow(@game).to receive(:owner_of).with(:alaska).and_return(3)
          expect(@attack_action.valid_on? @game).to be false
        end 

        it "returns false if defender does not own defending country" do 
          allow(@game).to receive(:owner_of).with(:kamchatka).and_return(3)
          expect(@attack_action.valid_on? @game).to be false
        end 

        it "returns false if attacker is the same as the defender" do 
          action = AttackAction.new(1, 1, :alaska, :kamchatka, 3)
          expect(action.valid_on? @game).to be false
        end

        it "returns false if number of armies in attacking country less than number attacking with - 1" do 
          allow(@game).to receive(:armies_in).with(:alaska).and_return(3)
          expect(@attack_action.valid_on? @game).to be false
        end

        it "returns false if attacking with greater than 3 armies" do 
          action = AttackAction.new(1, 2, :alaska, :kamchatka, 5)
          expect(action.valid_on? @game).to be false
        end
   
        it "returns false if attack_with < 1" do 
          action = AttackAction.new(1, 2, :alaska, :kamchatka, 0)
          expect(action.valid_on? @game).to be false
        end

        it "returns false if attacking_country does not exist" do 
          action = AttackAction.new(1, 2, :fake_country, :kamchatka, 3)
          expect(action.valid_on? @game).to be false
        end

        it "returns false if defending_country does not exist" do 
          action = AttackAction.new(1, 2, :alaska, :fake_country, 3)
          expect(action.valid_on? @game).to be false
        end

      end

    end

  end

end