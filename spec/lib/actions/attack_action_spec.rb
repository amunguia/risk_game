module Risk::Game

  describe AttackAction do 

    before :each do 
      @attack_action = AttackAction.new(1,2, :alaska, :kamchatka, 3)
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

  end

end