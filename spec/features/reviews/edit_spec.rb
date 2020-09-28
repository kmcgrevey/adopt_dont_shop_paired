require 'rails_helper'

RSpec.describe "test reviews can be edited", type: :feature do
  it "shows a new form to edit review" do

    paulas_shelter = Shelter.create!(name: "Paula's Precious Puppy Shelter",
                            address: "1234 Market Street",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80014")

    review_1 = paulas_shelter.reviews.create!(title: "Best Shelter",
                                    rating: 5,
                                    content: "These guys really know how to run a shelter!",
                                    picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

    visit "/shelters/#{paulas_shelter.id}"
    within "#review-#{review_1.id}" do
      click_on "Edit Review"
    end

    expect(current_path).to eq("/reviews/#{review_1.id}/edit")

    fill_in :title, with: "Jolliest and Most Joyful Home"
    choose(option: 4)
    fill_in :content, with: "The employees truly care about my pet!"

    click_button "Update Review"

    expect(current_path).to eq("/shelters/#{paulas_shelter.id}")
    within "#review-#{review_1.id}" do

      expect(page).to have_content("Jolliest and Most Joyful Home")
      expect(page).to have_content(4)
      expect(page).to have_content("The employees truly care about my pet!")
    end
  end

  it "shows a new form to edit review" do

    paulas_shelter = Shelter.create!(name: "Paula's Precious Puppy Shelter",
                            address: "1234 Market Street",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80014")

    review_1 = paulas_shelter.reviews.create!(title: "Best Shelter",
                            rating: 5,
                            content: "These guys really know how to run a shelter!",
                            picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

    visit "/reviews/#{review_1.id}/edit"

    fill_in :title, with: ""
    choose(option: 4)
    fill_in :content, with: ""

    click_button "Update Review"

    expect(current_path).to eq("/reviews/#{review_1.id}")
    expect(page).to have_content("Please fill in title, rating, and content")
  end
end
