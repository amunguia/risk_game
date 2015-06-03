module Risk::Game

  describe Action do 

    before :each do 
      @action = Action.new
    end

    describe ".execute_on" do 

      it "raises an error because its an abstract method" do 
        expect{ @action.execute_on(Game.new) }.to raise_error("Abstract method.")
      end

    end

    describe ".valid_on?" do 

      it "raises an error because its an abstract method" do 
        expect{ @action.valid_on?(Game.new) }.to raise_error("Abstract method.")
      end
      
    end

  end

end