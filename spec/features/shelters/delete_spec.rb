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
                        description: "Denver",
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

  it "can delete a shelter that has reviews and pets" do

    parkside_shelter = Shelter.create(name: "Parkside Shelter",
                                      address: "1234 Market Street",
                                      city: "Denver",
                                      state: "Colorado",
                                      zip: "80230")

    caesar = Pet.create(image: "https://thehappypuppysite.com/wp-content/uploads/2017/10/Cute-Dog-Names-HP-long.jpg",
                        name: "Caesar",
                        approx_age: "4",
                        city: "Denver",
                        sex: "Male",
                        shelter: parkside_shelter)

    review_1 = parkside_shelter.reviews.create!(title: "Best Shelter",
                                    rating: 5,
                                    content: "These guys really know how to run a shelter!",
                                    picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

    visit "/shelters"

    expect(page).to have_content(parkside_shelter.name)

    within "#shelter-#{parkside_shelter.id}" do
      click_link "Delete Shelter"
    end

    expect(page).to_not have_content(parkside_shelter.name)
    expect(page).to_not have_content(review_1.title)

    visit "/pets"

    expect(page).to_not have_content(caesar.name)
  end
end
