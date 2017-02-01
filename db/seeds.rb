# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 Product.create(:name => "signature fixie", :description => "I also created this product without using the HTML form!", :image_url => "/assets/fixie.jpg", :colour => "green", :price => "199.99")
 Product.create(:name => "vintage cruiser", :description => "I also created this product without using the HTML form!", :image_url => "/assets/vintage_cruiser.jpg", :colour => "green", :price => "199.99")
 Product.create(:name => "vintage road", :description => "I also created this product without using the HTML form!", :image_url => "/assets/vintage_road_bike.jpg", :colour => "green", :price => "199.99")
