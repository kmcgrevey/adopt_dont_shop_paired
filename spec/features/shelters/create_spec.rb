require 'rails_helper'

RSpec.describe "test user can create new shelters", type: :feature do
  it "creates a shelter" do

    visit "/shelters"
    have_link "New Shelter"
    click_link "New Shelter"

    expect(current_path).to eq("/shelters/new")

    fill_in "Name", with: "Downtown Puppy Shelter"
    fill_in "Address", with: "4567 Broad Street"
    fill_in "City", with: "Philadelphia"
    fill_in "State", with: "Pennsylvania"
    fill_in "Zip", with: "19019"
    click_button "Create Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("Downtown Puppy Shelter")
  end

  it "shows a flash message if create form is incomplete" do

    visit "/shelters"
    have_link "New Shelter"
    click_link "New Shelter"

    expect(current_path).to eq("/shelters/new")

    fill_in "Name", with: "Downtown Puppy Shelter"
    fill_in "Address", with: "4567 Broad Street"
    fill_in "City", with: "Philadelphia"
    fill_in "State", with: ""
    fill_in "Zip", with: ""

    expect(page).to have_content("Please fill in State")
    expect(page).to have_content("Please fill in Zip")
  end
end
