require 'rails_helper'

RSpec.describe "test pets show page", type: :feature do
  it "shows image, name, description, approx_age, sex, and adoptable/pending adoption status on index page" do
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
                        approx_age: "2",
                        city: "Denver",
                        sex: "Male",
                        shelter: parkside_shelter,
                        description: "This little rascal is fiesty and cute as a button!",
                        status: "Adoptable")

    livia = Pet.create(image: "https://en.bcdn.biz/Images/2018/6/6/ae2e9240-c42a-4a81-b6d8-ac65af25b827.jpg",
                        name: "Livia",
                        approx_age: "3",
                        city: "Columbia",
                        sex: "Female",
                        shelter: lakeside_shelter,
                        description: "She loves to snuggle up and be rubbed behind her ears!",
                        status: "Adoptable")

    visit "/pets/#{caesar.id}"

    expect(page).to have_css("img[src*='#{caesar.image}']")
    expect(page).to have_content(caesar.name)
    expect(page).to have_content(caesar.approx_age)
    expect(page).to have_content(caesar.sex)
    expect(page).to have_content(caesar.shelter.name)
    expect(page).to have_content(caesar.description)
    expect(page).to have_content(caesar.status)

    expect(page).to_not have_css("img[src*='#{livia.image}']")
    expect(page).to_not have_content(livia.name)
    expect(page).to_not have_content(livia.approx_age)
    expect(page).to_not have_content(livia.sex)
    expect(page).to_not have_content(livia.shelter.name)
    expect(page).to_not have_content(livia.description)

    visit "/pets/#{livia.id}"

    expect(page).to have_css("img[src*='#{livia.image}']")
    expect(page).to have_content(livia.name)
    expect(page).to have_content(livia.approx_age)
    expect(page).to have_content(livia.sex)
    expect(page).to have_content(livia.shelter.name)
    expect(page).to have_content(livia.description)
    expect(page).to have_content(livia.status)

    expect(page).to_not have_css("img[src*='#{caesar.image}']")
    expect(page).to_not have_content(caesar.name)
    expect(page).to_not have_content(caesar.approx_age)
    expect(page).to_not have_content(caesar.sex)
    expect(page).to_not have_content(caesar.shelter.name)
    expect(page).to_not have_content(caesar.description)
  end
end
