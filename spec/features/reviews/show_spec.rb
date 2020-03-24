require 'rails_helper'

RSpec.describe "test reviews are on shelter show page", type: :feature do
  it "see a list of reviews for shelter" do
    lakeside_shelter = Shelter.create(name: "Lakeside Shelter",
                                    address: "2914 Freetown Road",
                                    city: "Columbia",
                                    state: "Maryland",
                                    zip: "21044")

    review_1 = lakeside_shelter.reviews.create!(title: "Best Shelter",
                                    rating: 5,
                                    content: "These guys really know how to run a shelter!",
                                    picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")

    visit "/shelters/#{lakeside_shelter.id}"

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_css("img[src*='#{review_1.picture}']")
  end
end
