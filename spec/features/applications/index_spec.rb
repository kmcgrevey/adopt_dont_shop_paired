require "rails_helper"

RSpec.describe "test applications index page" do
  it "should show a message if no applications" do

    shelter_1 = Shelter.create!(name: "Burt's Barn",
                         address: "123 Sesame Street",
                         city: "New York",
                         state: "NY",
                         zip: "12345")

    pet_3 = shelter_1.pets.create!(image: "https://www.thesun.co.uk/wp-content/uploads/2019/10/NINTCHDBPICT000528091420.jpg?strip=all&w=960",
                          name: "Francisco",
                          description: "What, behind the rabbit!?",
                          approx_age: 3,
                          sex: "male",
                          status: "Pending")

    visit "pets/#{pet_3.id}/applications"

    expect(page).to have_content("There are no applications for this pet")
  end
end
