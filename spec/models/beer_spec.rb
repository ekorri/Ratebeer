require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved when it has a name and a style" do
  	beer = Beer.create name:"Karhu", style: Style.new(name: "lager")

  	expect(beer).to be_valid
  	expect(Beer.count).to eq(1)  	
  end

  it "is not saved without a name" do
  	beer = Beer.create style: Style.new(name: "lager")

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
  	beer = Beer.create name:"Karhu"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end
end
