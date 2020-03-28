require 'rails_helper'

RSpec.describe "new applications can be made", type: :feature do
  it "has a link to an application form for each pet on favorites index" do

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

    visit "/pets/#{pet_1.id}"

    click_button "Favorite"

    visit "/pets/#{pet_2.id}"

    click_button "Favorite"

    visit "/pets/#{pet_3.id}"

    click_button "Favorite"

    visit "/favorites"

    click_link "Apply For Adoption"

    expect(current_path).to eq("/applications/new")

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_2.name}")
    expect(page).to have_content("#{pet_3.name}")

    within "#checkbox-#{pet_1.id}" do
      check "#{pet_1.name}"
      # check 'Penelope'
    end

    within "#checkbox-#{pet_2.id}" do
      check "#{pet_2.name}"
    end

    fill_in "Name", with: "John Hutchinson"
    fill_in "Address", with: "4089 S. Broadway Street"
    fill_in "City", with: "Philadelphia"
    fill_in "State", with: "Pennsylvania"
    fill_in "Zip", with: "19050"
    fill_in "Phone Number", with: "215-367-8891"
    fill_in "Description", with: "I am loving and will provide a good home"

    click_button "Submit"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Your application has been submitted")

    expect(page).to_not have_content("#{pet_1.name}")
    expect(page).to_not have_content("#{pet_2.name}")
    expect(page).to have_content("#{pet_3.name}")
  end
end
