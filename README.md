# Project: Little Shop of Furniture

The Little Shop of Furniture is a fictitious e-commerce application that has admins, merchants, registered users, and visitors. Our application allows admins to manage all users.
Merchants can fulfill orders, change order status and enable/disable items.  Registered users and visitors can browse the items, place items in their shopping cart and checkout.
Customers of the site can register and log in.

## Visit our app on Heroku
https://little-shop-of-furniture.herokuapp.com/

## Intent  

This group project was completed in 10 days as a requirement for Module 2 at Turing School of Software and Design.

The project was built using Rails which implements the following:
* MVC design pattern.
* Object oriented programming principles.
* CRUD functions - create, read, update, delete.
* Behavior Driven Development - BDD.
* Advanced database queries and calculations using ActiveRecord.
* Authentication using bcrypt.
* Session management to implement authorization for various users and shopping cart experience.
* Feature and model testing with test coverage at 99% or better.
* FactoryBot to create objects for efficient testing.
* Version control using GitHub.
* Project management tool: GitHub Projects.

## Contributors
* [Alexandra Chakeres](https://github.com/chakeresa)
* [Billy Urrutia](https://github.com/CosmicSpagetti)
* [Smitha Hosmani](https://github.com/hsmitha26)
* [Stella Mainar](https://github.com/smainar)
* [Michael Karnes](https://github.com/mikekarnes123)

## System Requirements
* Rails 5.x
* ActiveRecord - PostgreSQL

## Gems Used
* Bcrypt
* Capybara
* FactoryBot
* Launchy
* Pry
* RSpec
* Shoulda Matchers
* Simplecov

## GitHub Repository
https://github.com/hsmitha26/little_shop_v2

## Database Diagram
![alt text](app/assets/images/little-shop-schema.png)

## Instructions
  ### How to setup:
      1. Clone the GitHub repository.
      2. Go to the directory with the new repo.  Run bundle install.
      3. Run rake db:{create,migrate,seed}
      4. Run rails s, visit localhost:3000 to view the app and navigate on your local server.

  ### Run tests:
        1. Run rspec.
        2. To run a single test, example: rspec ./spec/features/items/new_spec.rb:11
        3. The above example can be edited to run spec folders and files.

  ### Sample login credentials for users:
        1. Login as an admin: email admin@email.com, password: password
        2. Login as a merchant: email merchant@email.com, password: pw123
        3. Login as a customer: *create your own user account*

## Ready to shop?
To visit our shop, click on the link below:

https://little-shop-of-furniture.herokuapp.com/

![alt text](app/assets/images/app-screen-shot.png)
