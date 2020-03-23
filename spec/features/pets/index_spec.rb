require 'rails_helper'

RSpec.describe "test pets index page", type: :feature do
  it "shows all pet names on index page" do
    parkside_shelter = Shelter.create(name: "Parkside Shelter",
                                      address: "1234 Market Street",
                                      city: "Denver",
                                      state: "Colorado",
                                      zip: "80230")

    lakeside_shelter = Shelter.create(name: "Lakeside Shelter",
                                      address: "2914 Freetown Road",
                                      city: "Columbia",
                                      state: "Maryland",
                                      zip: "21044")

    caesar = Pet.create(image: "https://thehappypuppysite.com/wp-content/uploads/2017/10/Cute-Dog-Names-HP-long.jpg",
                        name: "Caesar",
                        approx_age: "4",
                        description: "Cute as a button",
                        city: "Denver",
                        sex: "Male",
                        shelter: parkside_shelter)

    livia = Pet.create(image: "https://en.bcdn.biz/Images/2018/6/6/ae2e9240-c42a-4a81-b6d8-ac65af25b827.jpg",
                        name: "Livia",
                        approx_age: "5",
                        description: "She's as fun as she is cute",
                        city: "Columbia",
                        sex: "Female",
                        shelter: lakeside_shelter)

    visit "/pets"

    expect(page).to have_css("img[src*='#{caesar.image}']")
    expect(page).to have_content(caesar.name)
    expect(page).to have_content(caesar.city)
    expect(page).to have_content(caesar.approx_age)
    expect(page).to have_content(caesar.sex)
    expect(page).to have_content(caesar.shelter.name)

    expect(page).to have_css("img[src*='#{livia.image}']")
    expect(page).to have_content(livia.name)
    expect(page).to have_content(livia.city)
    expect(page).to have_content(livia.approx_age)
    expect(page).to have_content(livia.sex)
    expect(page).to have_content(livia.shelter.name)

    within "#pets-#{livia.id}" do
      click_link "Edit Pet"
    end

    expect(current_path).to eq("/pets/#{livia.id}/edit")

    fill_in "Image", with: "https://upload.wikimedia.org/wikipedia/commons/3/34/Labrador_on_Quantock_%282175262184%29.jpg"
    fill_in "Name", with: "Domitian"
    fill_in "Approx age", with: "8"
    fill_in "Description", with: "Loves parks and frisbees"
    fill_in "Sex", with: "Male"

    click_button "Update Pet"

    expect(current_path).to eq("/pets/#{livia.id}")

    visit "/pets"

    within "#pets-#{livia.id}" do
      click_link "Delete Pet"
    end

    expect(page).to have_content(caesar.name)
    expect(page).to_not have_content(livia.name)
  end
end
