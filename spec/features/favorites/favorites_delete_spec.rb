require 'rails_helper'

RSpec.describe "As visitor" do
  describe "when I visit favorites index page" do
    xit "I click to remove pet from favorites and see favorite idicator down by 1" do
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
      
      visit "/pets/#{pet_1.id}"
      
      click_button "Favorite"
      
      visit "/pets/#{pet_2.id}"
      
      click_button "Favorite"

      visit '/favorites'

      expect(page).to have_content("Favorites: 2")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_2.name}")
      
      within "#favorites-#{pet_1.id}" do
        click_button "Remove From Favorites"
      end
      
      visit '/favorites'
    
      expect(page).to have_content("Favorites: 1")
      expect(page).not_to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_2.name}")
    end

    xit "I see a message when I have no favorites" do
      visit '/favorites'

      expect(page).to have_content("You Currently Have No Favorite Pets.")
    end

    it "I click to remove all favorited pets and see a message that I have no favorites" do
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
      
                             
      visit "/pets/#{pet_1.id}"
      
      click_button "Favorite"
      
      visit "/pets/#{pet_2.id}"
      
      click_button "Favorite"
      
      visit '/favorites'

      click_link "Remove All Favorites"

      expect(page).to have_content("You Currently Have No Favorite Pets.")
    end   
  end
end