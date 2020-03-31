<h1 align = center> Adopt Don't Shop (The McGrevey-Lynch Petopia) </h1> 

Contributers: 
[Michael Alex Lynch](https://github.com/mlynch5187) ,
[Kevin McGrevey](https://github.com/kmcgrevey)

#### Welcome to Adopt Don't Shop

  There's no need to shop when you can simply adopt. There are pets are located all over the country, in a variety of different shelters. Whether you are looking for a pet that loves the outdoors, or a pet who just loves to cuddle, we can help match you with a new best friend!

  In this app you will be able to browse a variety of pets and pet shelters. If you see pets you like, you can add them to your favorites list. You can also apply for pets, and receive approval through this app. Lastly, you can see a wide range of shelters, each with their own pets, reviews, and ratings. Visit our app at (https://mcgrevey-lynch-petopia.herokuapp.com/).
  
#### Downloading Your App to Your Device

  To get this app on your device, simply visit our GitHub repo at https://github.com/kmcgrevey/adopt_dont_shop_paired/edit/master. 
  
  At the top of the page click on the 'fork' button.
  
  This will make a copy of the app on your device!
  
  Now that we have forked the app, we'll need to clone it to your local device.
  
  Open the directory you'd like to clone to in your command line interface (such as Terminal on a Mac) and type 'git clone' followed by a space with the clone url. 
  
  It should look something like this in your CLI:
  
  'git clone https://github.com/kmcgrevey/adopt_dont_shop_paired.git'
  
  
#### App Setup

  The first things we'll need to do is make sure we have the right software installed to run Adopt Don't Shop.
  
  Type 'bundle install' in your CLI, and you will see your CLI install many 'gem' files. These files allow the app's code to function properly.
  
 Next, we will need to create the database that stores some of our app's information. 
 
 First, type 'rake db:create' in your CLI. This command creates the actual database for the app. 
 
 Once that is done, you'll want to enter 'rake db:migrate' into your CLI. 
 
 This command essentially creates a new 'version' of your app in the database. Lastly, we'll run 'rake db:seed'. 
  
  Your database is now setup!
  
  We'll check that everything is running smoothly by running 'bundle exec rspec' in your CLI. This will run a variety of tests on Adopt Don't Shop to check functionality. You should see all tests pass at 100% coverage!
  
  Now Adopt Don't Shop is ready for action! You can now open the file in a text editor such as Atom or VSCode and play with the code to your heart's content.
  
#### Check Out Adopt Don't Shop Online

  Ok, so how do we actually get this app onto a web browser?
  
  Simply type 'rails s' in your CLI, and you will now be able to view the code by navigating to 'localhost:3000' in your web broswer.
  

#### FAQ

  - Our code has been created to follow Create Read Update Delete (CRUD) functionality and Test Driven Design (TDD).
  
  - Our primary goal was to have a functioning website that is user friendly, logical, and free of pesky bugs.
  
  - We have left the app in a prime state for adding CSS styling, and improving the appearance for the viewer.
  
  - Please reach out to either of the contributors above with further questions or contents!
  

  
  
