Shelter.destroy_all
Pet.destroy_all
Review.destroy_all

shelter1 = Shelter.create!(name: "Burt's Barn",
                           address: "123 Sesame Street",
                           city: "New York",
                           state: "NY",
                           zip: "12345")
shelter2 = Shelter.create!(name: "Ernie's Everhome",
                           address: "505 Elmwood Drive",
                           city: "Chelsea",
                           state: "MA",
                           zip: "02468")

pet1 = shelter1.pets.create!(image: "https://assets.change.org/photos/3/yk/di/kLYkdIaPKknZpoD-800x450-noPad.jpg?1519383791",
                             name: "Penelope",
                             description: "A face only everyone could love!",
                             approx_age: 1,
                             sex: "female")
pet2 = shelter1.pets.create!(image: "https://external-preview.redd.it/P4X2K5llPbMkRkmFkycSPdDGAp051xJl0UF50bZRId4.jpg?auto=webp&s=5231b2f36d623b3258d36adbfbaf9be305f0d419",
                             name: "Petey",
                             description: "Rubber baby bacon booties!",
                             approx_age: 1,
                             sex: "male")
pet3 = shelter2.pets.create!(image: "https://www.thesun.co.uk/wp-content/uploads/2019/10/NINTCHDBPICT000528091420.jpg?strip=all&w=960",
                             name: "Francisco",
                             description: "What, behind the rabbit!?",
                             approx_age: 3,
                             sex: "male",
                             status: "Pending")

review1 = shelter1.reviews.create!(title: "Best Shelter",
                                    rating: 5,
                                    content: "These guys really know how to run a shelter!",
                                    picture: "https://www.rd.com/wp-content/uploads/2019/10/puppies-1-760x506.jpg")
review2 = shelter1.reviews.create!(title: "Pretty Good",
                                    rating: 4,
                                    content: "Great selection of pigs : )")