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

      click_on "Favorite"

      visit "/pets/#{livia.id}"

      click_on "Favorite"

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

  it "cannot be deleted with an approved application on it" do
    lakeside_shelter = Shelter.create!(name: "Lakeside Shelter",
                                      address: "2914 Freetown Road",
                                      city: "Columbia",
                                      state: "Maryland",
                                      zip: "21044")

    caesar = Pet.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2017/10/Cute-Dog-Names-HP-long.jpg",
                        name: "Caesar",
                        approx_age: "4",
                        description: "Denver",
                        sex: "Male",
                        shelter: lakeside_shelter)
   
    application_1 = Application.create!(name: "John Hutchinson",
                                        address: "4089 S. Broadway Street",
                                        city: "Philadelphia",
                                        state: "Pennsylvania",
                                        zip: "19050",
                                        phone: "215-367-8891",
                                        description: "I am loving and will provide a good home")
    
    ApplicationPet.create!(application_id: application_1.id, pet_id: caesar.id)

    visit "/applications/#{application_1.id}" 
    
    within "#app_pet-#{caesar.id}" do
      click_button "Approve Application" 
    end

    visit "/pets/#{caesar.id}"

    click_link "Delete Pet"

    expect(page).to have_content("Pet cannot be deleted due to pending application status")
  end

end
