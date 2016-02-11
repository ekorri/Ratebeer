require 'rails_helper'

describe "Beers"  do
   let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
   
   it "saved if name is valid" do
   	visit new_beer_path
    fill_in('beer[name]', with:'Karhu')
    #select('Koff', from: 'beer[brewery_id]')
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)   

   end

   it "not saved and shows error message if name not valid" do
   	visit new_beer_path
   	
   	click_button "Create Beer"
   	expect(page).to have_content "Name can't be blank"
   	expect(Beer.count).to eq(0)
   end
end