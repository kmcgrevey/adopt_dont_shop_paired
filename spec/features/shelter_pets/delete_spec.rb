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

    visit "/shelters/#{parkside_shelter.id}"
    click_link "Delete Shelter"

    expect(page).to have_content(lakeside_shelter.name)
    expect(page).to_not have_content(parkside_shelter.name)
  end
end
