require 'rails_helper'

RSpec.describe "test reviews can be deleted", type: :feature do
  it "test reviews can be deleted" do

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

    visit "/shelters/#{paulas_shelter.id}"

    within "#review-#{review_1.id}" do
      expect(page).to have_content("#{review_1.title}")
      expect(page).to have_content("#{review_1.content}")
    end

    within "#review-#{review_2.id}" do
      expect(page).to have_content("#{review_2.title}")
      expect(page).to have_content("#{review_2.content}")

      click_button "Delete Review"
    end

      expect(current_path).to eq("/shelters/#{paulas_shelter.id}")

      expect(page).to have_content("#{review_1.title}")
      expect(page).to_not have_content("#{review_2.title}")
  end
end
