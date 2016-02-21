require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("london").and_return(
      [ Place.new( name:"Lowlander", id: 1 ), Place.new( name:"Microbar", id: 2 ), Place.new( name:"Bierodrome", id: 3 ) ]
    )

    visit places_path
    fill_in('city', with: 'london')
    click_button "Search"

    expect(page).to have_content "Lowlander"
    expect(page).to have_content "Microbar"
    expect(page).to have_content "Bierodrome"
  end

  it "if none is returned, a message is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("Kuuma").and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'Kuuma')
    click_button "Search"

    expect(page).to have_content "No locations in Kuuma"
  end
end