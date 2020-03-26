require 'rails_helper'

RSpec.describe "As visitor" do
  describe "I see a favorite indicator" do
    it "that shows a pet count on any page" do
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
      visit "/shelters"
      
      expect(page).to have_content("Favorites: 0")
      
      visit "/pets"
      
      expect(page).to have_content("Favorites: 0")
      
      visit "/shelters/#{shelter_1.id}"
      
      expect(page).to have_content("Favorites: 0")
      
      visit "/pets/#{pet_1.id}"
      
      expect(page).to have_content("Favorites: 0")
    end 
  end
end