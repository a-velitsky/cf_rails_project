FactoryGirl.define do

  sequence(:description) {|n|  "description for test product #{n}"}
  sequence(:name) {|n|  "test product #{n}"}
  sequence(:id) {|n|  "#{rand(9999)}"}


  factory :product do
    id
    name
    description
    image_url "sig_fixie.jpg"
    price "99.99"
  end
  
  factory :updated_product, class: Product do
    name "updated name"
    description "updated description"
    image_url "sig_fixie.jpg"
    price "999.99"
    colour "green"
  end
end