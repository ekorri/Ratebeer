require 'rails_helper'

include Helpers

describe "Beers"  do
   let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
   let!(:user) { FactoryGirl.create :user }
   let!(:style) { FactoryGirl.create :style }

   before :each do
    sign_in(username:"Pekka", password:"Foobar1")
   end
   
   it "saved if name is valid" do
   	visit new_beer_path
    fill_in('beer[name]', with:'Karhu')
    #select('Koff', from: 'beer[brewery_id]')
    select('Lager', from:'beer[style_id]')
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