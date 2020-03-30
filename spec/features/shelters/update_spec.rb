require 'rails_helper'

RSpec.describe "test user can update shelters", type: :feature do
  it "updates a shelter's information" do

    shelter_1 = Shelter.create(name: "Paula's Precious Puppy Shelter",
                            address: "1234 Market Street",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80014")

    visit "/shelters/#{shelter_1.id}"

    have_link "Update Shelter"
    click_link "Update Shelter"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    fill_in "Name", with: "Downtown Puppy Shelter"
    fill_in "Address", with: "4567 Broad Street"
    fill_in "City", with: "Philadelphia"
    fill_in "State", with: "Pennsylvania"
    fill_in "Zip", with: "19019"

    click_button "Submit"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Downtown Puppy Shelter")
    expect(page).to_not have_content("Paula's Precious Puppy Shelter")
  end

  it "shows a flash message upon submitting an incomplete edit form" do

    shelter_1 = Shelter.create(name: "Paula's Precious Puppy Shelter",
                            address: "1234 Market Street",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80014")

    visit "/shelters/#{shelter_1.id}"

    click_link "Update Shelter"

    fill_in "Name", with: ""
    fill_in "Address", with: ""
    fill_in "City", with: "Philadelphia"
    fill_in "State", with: "Pennsylvania"
    fill_in "Zip", with: "19019"

    expect(page).to have_content("Name can't be blank and Address can't be blank")
  end
end
