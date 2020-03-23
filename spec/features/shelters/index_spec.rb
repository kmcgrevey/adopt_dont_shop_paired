require 'rails_helper'

RSpec.describe "test shelters index page", type: :feature do
  it "shows all shelter names on index page" do
    parkside_shelter = Shelter.create!(name: "Parkside Shelter",
                                      address: "1234 Market Street",
                                      city: "Denver",
                                      state: "Colorado",
                                      zip: "80230")

    lakeside_shelter = Shelter.create!(name: "Lakeside Shelter",
                                      address: "2914 Freetown Road",
                                      city: "Columbia",
                                      state: "Maryland",
                                      zip: "21044")

    visit "/shelters"

    expect(page).to have_content(parkside_shelter.name)
    expect(page).to have_content(lakeside_shelter.name)

    within "#shelter-#{parkside_shelter.id}" do
      click_link "Edit Shelter"
    end

    expect(current_path).to eq("/shelters/#{parkside_shelter.id}/edit")

    fill_in "Name", with: "Riverside Shelter"
    fill_in "Address", with: "3197 Sutherland Parkway"
    fill_in "City", with: "Riverside"
    fill_in "State", with: "California"
    fill_in "Zip", with: "90217"

    click_button "Submit"

    expect(current_path).to eq("/shelters/#{parkside_shelter.id}")

    visit "/shelters"

    within "#shelter-#{parkside_shelter.id}" do
      click_link "Delete Shelter"
    end

    expect(page).to have_content(lakeside_shelter.name)
    expect(page).to_not have_content(parkside_shelter.name)
  end
end
