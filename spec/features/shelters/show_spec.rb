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

    click_link "All Pets"

    expect(page).to have_content("Adoptable Pets")
    expect(page).to have_content("Create Pet")

    it "see a list of reviews for shelter" do

    lakeside_shelter = Shelter.create(name: "Lakeside Shelter",
                                      address: "2914 Freetown Road",
                                      city: "Columbia",
                                      state: "Maryland",
                                      zip: "21044")

    review_1 = Shelter.reviews.create(title: "Best Shelter",
                                      rating: 5,
                                      content: "These guys really know how to run a shelter!",
                                      picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

    visit "/shelters/#{lakeside_shelter.id}"

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_css("img[src*='#{review_1.picture}']")
  end
end
