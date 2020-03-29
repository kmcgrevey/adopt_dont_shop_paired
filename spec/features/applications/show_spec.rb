require 'rails_helper'

RSpec.describe "test applications show page" do
  it "shows name, address, city, state, zip, and phone number on application's id page" do

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

    pet_2 = shelter_1.pets.create!(image: "https://external-preview.redd.it/P4X2K5llPbMkRkmFkycSPdDGAp051xJl0UF50bZRId4.jpg?auto=webp&s=5231b2f36d623b3258d36adbfbaf9be305f0d419",
                          name: "Petey",
                          description: "Rubber baby bacon booties!",
                          approx_age: 1,
                          sex: "male")

    pet_3 = shelter_1.pets.create!(image: "https://www.thesun.co.uk/wp-content/uploads/2019/10/NINTCHDBPICT000528091420.jpg?strip=all&w=960",
                          name: "Francisco",
                          description: "What, behind the rabbit!?",
                          approx_age: 3,
                          sex: "male",
                          status: "Pending")

    application_1 = Application.create!(name: "John Hutchinson",
                                address: "4089 S. Broadway Street",
                                city: "Philadelphia",
                                state: "Pennsylvania",
                                zip: "19050",
                                phone: "215-367-8891",
                                description: "I am loving and will provide a good home")

    application_1.pets << [pet_1, pet_2]

    visit "applications/#{application_1.id}"

    expect(page).to have_content("#{application_1.name}")
    expect(page).to have_content("#{application_1.address}")
    expect(page).to have_content("#{application_1.city}")
    expect(page).to have_content("#{application_1.state}")
    expect(page).to have_content("#{application_1.zip}")
    expect(page).to have_content("#{application_1.phone}")
    expect(page).to have_content("#{application_1.description}")
    expect(page).to have_link("#{pet_1.name}")
    expect(page).to have_link("#{pet_2.name}")
  end

  xit "shows a link to approve pet's applications, the link takes you to pet show page, shows adopter, and changes status to pending" do

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

    pet_2 = shelter_1.pets.create!(image: "https://external-preview.redd.it/P4X2K5llPbMkRkmFkycSPdDGAp051xJl0UF50bZRId4.jpg?auto=webp&s=5231b2f36d623b3258d36adbfbaf9be305f0d419",
                          name: "Petey",
                          description: "Rubber baby bacon booties!",
                          approx_age: 1,
                          sex: "male")

    pet_3 = shelter_1.pets.create!(image: "https://www.thesun.co.uk/wp-content/uploads/2019/10/NINTCHDBPICT000528091420.jpg?strip=all&w=960",
                          name: "Francisco",
                          description: "What, behind the rabbit!?",
                          approx_age: 3,
                          sex: "male",
                          status: "Pending")

    application_1 = Application.create!(name: "John Hutchinson",
                                address: "4089 S. Broadway Street",
                                city: "Philadelphia",
                                state: "Pennsylvania",
                                zip: "19050",
                                phone: "215-367-8891",
                                description: "I am loving and will provide a good home")

    application_1.pets << [pet_1, pet_2]

    visit "applications/#{application_1.id}"

    within "#app_pet-#{pet_1.id}" do
      click_link ("Approve Application")
    end

    expect(current_path).to eq("pets/#{pet_1.id}")
    expect(page).to have_content("Pending")
  end

  xit "shows a link to approve pet's applications, the link takes you to pet show page, shows adopter, and changes status to pending" do

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

    pet_2 = shelter_1.pets.create!(image: "https://external-preview.redd.it/P4X2K5llPbMkRkmFkycSPdDGAp051xJl0UF50bZRId4.jpg?auto=webp&s=5231b2f36d623b3258d36adbfbaf9be305f0d419",
                          name: "Petey",
                          description: "Rubber baby bacon booties!",
                          approx_age: 1,
                          sex: "male")

    pet_3 = shelter_1.pets.create!(image: "https://www.thesun.co.uk/wp-content/uploads/2019/10/NINTCHDBPICT000528091420.jpg?strip=all&w=960",
                          name: "Francisco",
                          description: "What, behind the rabbit!?",
                          approx_age: 3,
                          sex: "male",
                          status: "Pending")

    application_1 = Application.create!(name: "John Hutchinson",
                                address: "4089 S. Broadway Street",
                                city: "Philadelphia",
                                state: "Pennsylvania",
                                zip: "19050",
                                phone: "215-367-8891",
                                description: "I am loving and will provide a good home")

    application_1.pets << [pet_1, pet_2]

    visit "applications/#{application_1.id}"

    within "#app_pet-#{pet_1.id}" do
      click_link ("Approve Application")
    end
    #NEED TO MODIFY/CHECK!
    within "#app_pet-#{pet_2.id}" do
      click_link ("Approve Application")
    end

    expect(current_path).to eq("pets/#{pet_1.id}")
    expect(page).to have_content("Pending")
  end
end

  # <%= link_to "Approve Application", "/applications/#{@application.id}/pets/#{pet.id}", method: :patch do %>
