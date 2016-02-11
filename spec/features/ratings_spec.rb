require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
   sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(User.first.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "ratings and total number of ratings shown on ratings page" do
    FactoryGirl.create(:rating, beer: beer1, user: user)
    FactoryGirl.create(:rating, beer: beer2, user: user)

    visit ratings_path

    expect(page).to have_content 'Number of ratings: 2'
    expect(Rating.count).to eq(2)
  end

  it "users ratings shown on users own page" do
    FactoryGirl.create(:rating, beer: beer1, user: user)
    FactoryGirl.create(:rating, beer: beer2, user: user)
    FactoryGirl.create(:rating, beer: beer2, user: user)

    visit user_path(user)

    expect(page).to have_content 'Has made 3 ratings'
    expect(user.ratings.count).to eq(3)
  end

  it "when user deletes rating, rating is removed from database" do
    FactoryGirl.create(:rating, beer: beer1, user: user)
    visit user_path(user)
    page.all('a', :text => 'delete').first.click

    expect(user.ratings.count).to eq(0)
  end
end