require 'rails_helper'

RSpec.describe "test shelters show page", type: :feature do
  it "a shelter and it's pets accessible by shelter name from shelter index" do
    parkside_shelter = Shelter.create(name: "Parkside Shelter",
                                      address: "1234 Market Street",
                                      city: "Denver",
                                      state: "Colorado",
                                      zip: "80230")

    lakeside_shelter = Shelter.create(name: "Lakeside Shelter",
                                      address: "2914 Freetown Road",
                                      city: "Columbia",
                                      state: "Maryland",
                                      zip: "21044")

    visit "/shelters"

    within "#shelters-#{parkside_shelter.id}"
      click_link "Parkside Shelter"

    expect(page).to have_content(parkside_shelter.name)
    expect(page).to have_content(parkside_shelter.address)
    expect(page).to have_content(parkside_shelter.city)
    expect(page).to have_content(parkside_shelter.state)
    expect(page).to have_content(parkside_shelter.zip)
    expect(page).to_not have_content(lakeside_shelter.name)

    click_link "Our Pets" #qweqwew

    expect(page).to have_content("Adoptable Pets")
    expect(page).to have_content("Create Pet")
  end
end
