require 'rails_helper'

RSpec.describe "test delete shelters", type: :feature do
  it "deletes a shelter from index" do
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

    caesar = Pet.create(image: "https://thehappypuppysite.com/wp-content/uploads/2017/10/Cute-Dog-Names-HP-long.jpg",
                        name: "Caesar",
                        approx_age: "4",
                        city: "Denver",
                        sex: "Male",
                        shelter: parkside_shelter)

    visit "/shelters"

    expect(page).to have_content(parkside_shelter.name)
    expect(page).to have_content(lakeside_shelter.name)

    visit "/pets"

    expect(page).to have_content(caesar.name)

    visit "/shelters/#{parkside_shelter.id}"
    click_link "Delete Shelter"

    visit "/shelters"

    expect(page).to have_content(lakeside_shelter.name)
    expect(page).to_not have_content(parkside_shelter.name)
  end
end
