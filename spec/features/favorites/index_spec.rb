require 'rails_helper'

RSpec.describe "As visitor" do
  describe "I see a favorites index page" do
    it "that shows every pet that has been favorited" do

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

      expect(page).to have_content("Favorites: 1")

      visit "/pets/#{pet_2.id}"

      click_button "Favorite"

      visit "/favorites"

      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to have_css("img[src*='#{pet_2.image}']")
      expect(page).to_not have_content("#{pet_3.name}")

      click_link "#{pet_1.name}"

      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content("#{pet_1.description}")
    end

    it "when I click favorites indicator in nav bar" do
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

      visit "/pets/#{pet_1.id}"

      click_button "Favorite"

      within ".topnav" do
        click_link "Favorites"
      end

      expect(current_path).to eq('/favorites')
      expect(page).to have_content(pet_1.name)
    end
  end

  it "has a section listing all of the pets with applications on them" do

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
                          sex: "male")

      visit "/pets/#{pet_1.id}"

      click_button "Favorite"

      expect(page).to have_content("Favorites: 1")

      visit "/pets/#{pet_2.id}"

      click_button "Favorite"

      visit "/pets/#{pet_3.id}"

      click_button "Favorite"

      visit "/favorites"

      click_link "Apply For Adoption"

      visit '/applications/new'

      within "#checkbox-#{pet_1.id}" do
        check "applied_for_"
      end

      within "#checkbox-#{pet_2.id}" do
        check "applied_for_"
      end

      fill_in "Name", with: "John Hutchinson"
      fill_in "Address", with: "4089 S. Broadway Street"
      fill_in "City", with: "Philadelphia"
      fill_in "State", with: "Pennsylvania"
      fill_in "Zip", with: "19050"
      fill_in "Phone", with: "215-367-8891"
      fill_in "Description", with: "I am loving and will provide a good home"

      click_button "Submit"

      expect(current_path).to eq("/favorites")

    within "#applied_for" do
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_2.name}")
      expect(page).to_not have_content("#{pet_3.name}")
    end

      click_link "#{pet_1.name}"

      expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end
