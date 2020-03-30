require 'rails_helper'

RSpec.describe "test delete pets", type: :feature do
  it "deletes a pet from index" do
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

    livia = Pet.create(image: "https://en.bcdn.biz/Images/2018/6/6/ae2e9240-c42a-4a81-b6d8-ac65af25b827.jpg",
                        name: "Livia",
                        approx_age: "5",
                        description: "Columbia",
                        sex: "Female",
                        shelter: lakeside_shelter)

                        visit "/pets/#{caesar.id}"
                        click_link "Delete Pet"

    expect(page).to have_content(livia.name)
    expect(page).to_not have_content(caesar.name)
  end

  it "when pet is deleted it is also removed from favorites and favorites counter decrements by one" do

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
                        shelter: lakeside_shelter)

    livia = Pet.create(image: "https://en.bcdn.biz/Images/2018/6/6/ae2e9240-c42a-4a81-b6d8-ac65af25b827.jpg",
                        name: "Livia",
                        approx_age: "5",
                        description: "Columbia",
                        sex: "Female",
                        shelter: lakeside_shelter)

      visit "/pets/#{caesar.id}"

      click_button "Favorite"

      visit "/pets/#{livia.id}"

      click_button "Favorite"

      visit "/favorites"

      expect(page).to have_content("#{livia.name}")
      expect(page).to have_content("#{caesar.name}")
      expect(page).to have_content("Favorites: 2")


      visit "/pets/#{caesar.id}"

      click_link "Delete Pet"

      visit "/favorites"

      expect(page).to have_content("#{livia.name}")
      expect(page).to_not have_content("#{caesar.name}")
      expect(page).to have_content("Favorites: 1")

      visit "/pets"

      expect(page).to have_content("#{livia.name}")
      expect(page).to_not have_content("#{caesar.name}")
  end
end
