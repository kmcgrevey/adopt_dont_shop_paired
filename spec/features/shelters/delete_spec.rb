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

  it "shows a flash message if user tries to delete a shelter with an approved pet" do

    shelter_1 = Shelter.create!(name: "Burt's Barn",
                         address: "123 Sesame Street",
                         city: "New York",
                         state: "NY",
                         zip: "12345")

    pet_1 = shelter_1.pets.create!(image: "https://assets.change.org/photos/3/yk/di/kLYkdIaPKknZpoD-800x450-noPad.jpg?1519383791",
                          name: "Penelope",
                          description: "A face only everyone could love!",
                          approx_age: 1,
                          sex: "female")

    pet_2 = shelter_1.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2017/10/Cute-Dog-Names-HP-long.jpg",
                        name: "Caesar",
                        approx_age: "4",
                        description: "Denver",
                        sex: "Male")

    application_1 = Application.create!(name: "John Hutchinson",
                                address: "4089 S. Broadway Street",
                                city: "Philadelphia",
                                state: "Pennsylvania",
                                zip: "19050",
                                phone: "215-367-8891",
                                description: "I am loving and will provide a good home")

    application_1.pets << [pet_1, pet_2]

    visit "/shelters/#{shelter_1.id}"
    expect(page).to have_link("Delete Shelter")

    visit "/applications/#{application_1.id}"

    within "#app_pet-#{pet_1.id}" do
      click_button ("Approve Application")
    end

    visit "/shelters/#{shelter_1.id}"
    expect(page).to_not have_link("Delete Shelter")
  end
end
