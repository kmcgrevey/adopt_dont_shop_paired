require 'rails_helper'

RSpec.describe "test new pet can be created for specific shelter", type: :feature do
  it "creates new adoptable pet for shelter" do
    beachside_shelter = Shelter.create(name: "Beachside Shelter",
                                      address: "1234 Sandy Street",
                                      city: "Rehoboth Beach",
                                      state: "Delaware",
                                      zip: "19971")

    visit "/shelters/#{beachside_shelter.id}/pets"

    click_link "Create Pet"

    expect(current_path).to eq("/shelters/#{beachside_shelter.id}/pets/new")

    fill_in "Image", with: "https://cdn2-www.dogtime.com/assets/uploads/gallery/newfoundland-dogs-and-puppies/newfoundland-dogs-puppies-1.jpg"
    fill_in "Name", with: "Augustus"
    fill_in "Approx age", with: "12"
    fill_in "Description", with: "Augustus is former guide dog looking for a new home"
    choose(option: 'Male')

    click_button "Create Pet"

    expect(current_path).to eq("/shelters/#{beachside_shelter.id}/pets")

    expect(page).to have_content("Augustus")
    expect(page).to have_content("Adoptable")
  end

  it "shows a flash message upon submitting an incomplete form" do

    beachside_shelter = Shelter.create(name: "Beachside Shelter",
                                      address: "1234 Sandy Street",
                                      city: "Rehoboth Beach",
                                      state: "Delaware",
                                      zip: "19971")

    visit "/shelters/#{beachside_shelter.id}/pets"

    click_link "Create Pet"

    fill_in "Image", with: "https://cdn2-www.dogtime.com/assets/uploads/gallery/newfoundland-dogs-and-puppies/newfoundland-dogs-puppies-1.jpg"
    fill_in "Name", with: ""
    fill_in "Approx age", with: "12"
    fill_in "Description", with: ""
    choose(option: 'Female')

    click_button "Create Pet"

    expect(current_path).to eq("/shelters/#{beachside_shelter.id}/pets")
    expect(page).to have_content("Name can't be blank and Description can't be blank")
  end
end
