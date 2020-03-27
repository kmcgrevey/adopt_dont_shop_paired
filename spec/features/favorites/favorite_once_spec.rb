require 'rails_helper'

RSpec.describe "As visitor" do
  describe "when I visit pet show page" do
    it "I click to remove pet from favorites and see confirm message" do
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
      
      expect(page).to have_content("Favorites: 1")
      
      click_button "Remove From Favorites"

      expect(page).to have_content("Penelope has been removed from your favorites.")
      expect(page).to have_content("Favorites: 0")
    end
  end
end