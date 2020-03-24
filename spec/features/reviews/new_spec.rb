require 'rails_helper'

RSpec.describe "test new reviews can be made from shelter show page", type: :feature do
  it "see a form to fill out with review attributes" do
    lakeside_shelter = Shelter.create(name: "Lakeside Shelter",
                                    address: "2914 Freetown Road",
                                    city: "Columbia",
                                    state: "Maryland",
                                    zip: "21044")

    visit "/shelters/#{lakeside_shelter.id}"
    click_button "New Review"

    expect(current_path).to eq("/shelters/#{lakeside_shelter.id}/reviews/new")

      fill_in :title, with: "Mediocre At Best"
      fill_in :rating, with: 2
      fill_in :content, with: "Just meh. Nothing special here"
      fill_in :picture, with: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg"

    click_button "Create Review"

    expect(current_path).to eq("/shelters/#{lakeside_shelter.id}")

      expect(page).to have_content("Mediocre At Best")
      expect(page).to have_content(2)
      expect(page).to have_content("Just meh. Nothing special here")
      expect(page).to have_css("img[src*='https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg']")
  end
end
