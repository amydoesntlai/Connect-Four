require_relative 'spec_helper'

describe Column do

  before :each do
    @column = Column.new
  end


  context '#initialize' do

    it 'is intialized to have 6 0s' do
      0.upto(5) do |num|
        @column.get_value_at(num).should eq " "
      end
    end

  end

  context '#insert' do
    it 'adds a something to an empty column' do
      @column.insert("O")
      @column.get_value_at(0).should_not eq " "
    end

    it "doesn't add to a full column" do
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.insert("X")
      @column.insert("O")
      @column.insert("X")
      @column.insert("O").should be_nil
    end

    it "populates the column at the given place with the given marker" do
      @column.insert("O")
      @column.insert("O")
      @column.insert("O")
      @column.insert("X")
      @column.get_value_at(3).should eq "X"
    end
  end

  context '#get_value_at' do
    it 'returns the correct value from a given space' do
      @column.insert("O")
      @column.insert("O")
      @column.insert("O")
      @column.insert("X")
      @column.get_value_at(3).should eq "X"
    end

    it 'returns 0 from an empty space' do
      @column.get_value_at(5).should eq " "
    end

  end


end
