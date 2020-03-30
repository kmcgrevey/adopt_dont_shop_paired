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

    click_link "Our Pets"

    expect(page).to have_content("Adoptable Pets")
    expect(page).to have_content("Create Pet")
  end

  it "shows statistics for that shelter" do

    paulas_shelter = Shelter.create!(name: "Paula's Precious Puppy Shelter",
                            address: "1234 Market Street",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80014")

    review_1 = paulas_shelter.reviews.create!(title: "Best Shelter",
                                    rating: 5,
                                    content: "These guys really know how to run a shelter!",
                                    picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

    review_2 = paulas_shelter.reviews.create!(title: "Whatever, man",
                                    rating: 2,
                                    content: "The employees gave me an attitude. No one talks to me like that!")

    pet_1 = paulas_shelter.pets.create!(image: "https://assets.change.org/photos/3/yk/di/kLYkdIaPKknZpoD-800x450-noPad.jpg?1519383791",
                          name: "Penelope",
                          description: "A face only everyone could love!",
                          approx_age: 1,
                          sex: "female")

    pet_2 = paulas_shelter.pets.create!(image: "https://external-preview.redd.it/P4X2K5llPbMkRkmFkycSPdDGAp051xJl0UF50bZRId4.jpg?auto=webp&s=5231b2f36d623b3258d36adbfbaf9be305f0d419",
                          name: "Petey",
                          description: "Rubber baby bacon booties!",
                          approx_age: 1,
                          sex: "male")

    pet_3 = paulas_shelter.pets.create!(image: "https://www.thesun.co.uk/wp-content/uploads/2019/10/NINTCHDBPICT000528091420.jpg?strip=all&w=960",
                          name: "Francisco",
                          description: "What, behind the rabbit!?",
                          approx_age: 3,
                          sex: "male")

    application_1 = Application.create!(name: "John Hutchinson",
                                address: "4089 S. Broadway Street",
                                city: "Philadelphia",
                                state: "Pennsylvania",
                                zip: "19050",
                                phone: "215-367-8891",
                                description: "I am loving and will provide a good home")

    application_2 = Application.create!(name: "Mike Jones",
                                address: "8091 Charles Street",
                                city: "Baltimore",
                                state: "Maryland",
                                zip: "20239",
                                phone: "410-743-8819",
                                description: "I am the single greatest pet owner in the history of owning pets")

    application_1.pets << [pet_1, pet_2]
    application_2.pets << [pet_1, pet_2, pet_3]

    visit "/shelters/#{paulas_shelter.id}"

    expect(page).to have_content("Pet Count: 3")
    expect(page).to have_content("Average Rating: 3.5")
    expect(page).to have_content("Number Of Applications On File: 5")
  end
end
