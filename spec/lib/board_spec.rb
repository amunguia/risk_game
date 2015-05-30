module Risk::Game

  describe Board do 
    before :each do 
      @board = Board.new
    end


    describe "#adjacent_to" do 
      it "throws an exception if the country does not exist" do 
        expect{ @board.adjacent_to :fake_country }.to raise_error(CountryDoesNotExist)
      end

      it "returns an array if the country does exist" do
        expect(@board.adjacent_to :alaska).to be_kind_of(Array)
      end

    end

    describe "#countries" do 
      it "returns an array of symbols" do 
        expect(@board.countries).to be_kind_of(Array)
      end

      it "returns an array of length 42" do 
        expect(@board.countries.length).to eq 42
      end
    end

    describe "#name_for" do 
      it "throws an exception if the country does not exist" do 
        expect{ @board.name_for :fake_country }.to raise_error(CountryDoesNotExist)
      end

      it "returns an array if the country does exist" do 
        expect(@board.name_for :alaska).to be_kind_of(String)
      end 
    end

  end

end